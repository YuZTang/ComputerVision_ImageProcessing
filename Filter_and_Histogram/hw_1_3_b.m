I=imread('nut_and_shell.bmp');
gray_level=rgb2gray(I);
contrast=immultiply(gray_level,3); %�[�j���
imhist(contrast);
level=graythresh(contrast);
bw=im2bw(contrast,level); 
bw=~bw; %�N�¥դ���A�]��bwlabel�O��զ⪺��������A��Ϫ����󬰶¦�
figure
imshow(bw);

[~,n]=bwlabel(bw);%�u�ݭn����ƥشN�n
stats=regionprops(bw,'Area','centroid')%�n�D���n��ΤߦӤw
nut=stats(1)
shell=stats(2)
n


