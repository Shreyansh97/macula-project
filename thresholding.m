function B=thresholding(I);
G=I(:,:,2);
[count binLoc]=imhist(G);
l2=255;
l1=0;
for i=255:-1:0
    if count(i)>1000
        l1=i;
        break;
    end
end
T(1)=(l1+l2)/2;
d=1;
B=im2bw(I,T(1)/255);
[r c]=size(B);
for k=1:2
    m=[0 0];
    n=[0 0];
    for i=1:r
        for j=1:c
            if B(i,j)==1
                m(1)=m(1)+double(G(i,j));
                n(1)=n(1)+1;
            else
                m(2)=m(2)+double(G(i,j));
                n(2)=n(2)+1;
            end
        end
    end
    d=d+1;
    T(d)=((m(1)/n(1))+(m(2)/n(2)))/2;
    %B=im2bw(I,T(d)/255);
    %figure,imshow(B);
end
% SL=strel('disk',5);
% SE=strel('disk',10);
% %imshow(B);
% B=imerode(B,SL);
% B=imdilate(B,SE);
%imshow(B);
imwrite(B,'temp_disk.jpg');