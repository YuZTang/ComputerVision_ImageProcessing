I=imread('nut_and_shell.bmp');
gray_level=rgb2gray(I);
contrast=immultiply(gray_level,3); %加強對比
imhist(contrast);
level=graythresh(contrast);
bw=im2bw(contrast,level); 
bw=~bw; %將黑白反轉，因為bwlabel是把白色的視為物件，原圖的物件為黑色
figure
imshow(bw);

[~,n]=bwlabel(bw);%只需要物件數目就好
stats=regionprops(bw,'Area','centroid')%要求面積跟形心而已
nut=stats(1)
shell=stats(2)
n


