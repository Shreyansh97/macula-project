function j = optic_disk(im_rgb)
%clear
%im_rgb = imread('Large.jpg');
im_luv = rgb2xyz(im_rgb);
C = makecform('xyz2uvl');
im_luv = applycform(im_luv,C);
se = strel('disk',8);
im_l = im_luv(:,:,3);
im_close = imclose(im_l,se);
level = graythresh(im_close)+0.21;
im_th = im2bw(im_close,level);
% figure,imshow(im_th);

%second part
im_u=im_luv(:,:,1);
im_v=im_luv(:,:,2);
fin = find(im_th==1);
im_u(fin) = 0;
im_v(fin) = 0;
im_l(fin) = 0;
im_2 = cat(3,im_u,im_v,im_l);
% figure,imshow(im_2);

%third part
se2 = strel('disk',5);
im_3 = imdilate(im_2,se2);
while numel(im_3(im_3 == 0))>0
    im_3 = imdilate(im_3,se2);
end
% figure,imshow(im_3);

%fourth part
level2 = graythresh(im_3);
im_th2 = im2bw(im_luv - im_3,0.01);
% figure,imshow(im_th2);
% second_optic(im_th2);

CC=bwconncomp(im_th2);
j = zeros(size(im_th));
numPixels = cellfun(@numel,CC.PixelIdxList);
[comps,idx]=max(numPixels);
j(CC.PixelIdxList{idx}) = 1;
j=im2bw(j,0.5);
stats = regionprops('table',j,'Centroid','MajorAxisLength','MinorAxisLength');
location = [stats.Centroid stats.MajorAxisLength/2];
j = insertShape(im_rgb,'Circle',location,'Color','White','Opacity',1,'LineWidth',3);
hold off;