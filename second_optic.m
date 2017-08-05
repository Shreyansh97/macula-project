function second_optic(L)
[r c]=find(L==1);
rc=[r c];
max_r = abs(r(1)-r(end));
max_c = abs(c(1)-c(end));
if(max_r<max_c)
    radius = max_r;
else
    radius = max_c;
end
area = numel(rc);
if(area >3000)
    region_border = pi*radius;
    mm = 4*pi*(area/(region_border * region_border));
    m=abs(area-mm);
else
    m=inf;
end


se3 = strel('disk',7);
LL = imdilate(LL,se3);
