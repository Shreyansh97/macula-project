function J = hi(a)
h=fspecial('average',6);
a=imfilter(a,h);