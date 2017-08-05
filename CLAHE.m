function [J]=CLAHE(I,c)
LAB=rgb2lab(I);
L=LAB(:,:,1)/100;
LAB(:,:,1)=adapthisteq(L,'ClipLimit',c)*100;
J=lab2rgb(LAB);
%J=unint8(J);