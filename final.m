for x=1:61
    file=strcat('C:\Users\Shreyansh\Documents\MATLAB\Fundus Photographs from srikanth prabhu\Normal\normal',int2str(x),'.jpg');
    J=imread(file);
%     imwrite(CLAHE(J,0.04),'temp.jpg');
%     I=imread('temp.jpg');
    I=optic_disk(J);
    output=strcat('outputs\normal',int2str(x),'.jpg');
    imwrite(I,output);
end
