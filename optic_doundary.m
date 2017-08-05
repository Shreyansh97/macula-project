function im_final = optic_doundary(im_rgb)
im_luv = rgb2xyz(im_rgb);
C = makecform('xyz2uvl');
im_luv = applycform(im_luv,C);
se = strel('disk',8);
im_l = im_luv(:,:,3);
im_close = imclose(im_l,se);
level = graythresh(im_close)+0.21;
im_th = im2bw(im_close,level);
% figure,imshow(im_th),title('threshold');

CC = bwconncomp(im_th);
im = zeros(size(im_th));
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
im(CC.PixelIdxList{idx}) = 1;
im = im2bw(im,0.5);
% figure,imshow(im),title('largest');

stats = regionprops('table',im,'Centroid','MajorAxisLength','MinorAxisLength');
% figure,imshow(im_rgb),title('original'), hold on;
% viscircles(stats.Centroid,stats.MajorAxisLength / 2,'Color','w');
location = [stats.Centroid stats.MajorAxisLength/2];
im_final = insertShape(im_rgb,'Circle',location,'Color','White','Opacity',1,'LineWidth',3);
hold off;