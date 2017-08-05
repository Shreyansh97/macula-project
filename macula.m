function [D I]=macula(I)
J=I(:,:,2);
SE=strel('disk',5);
G=J+imtophat(J,SE)-imbothat(J,SE);
H=adapthisteq(G,'ClipLimit',0.04);
B=imcomplement(logical(bitget(H,7)));
O=imopen(B,SE);
D=imdilate(O,SE);
imwrite(D,'temp_macula.jpg');
P=bwperim(D);
[r c]=size(J);
for i=1:r
    for j=1:c
        if P(i,j)==1
            for k=1:3
                I(i,j,k)=255;
            end
        end
    end
end