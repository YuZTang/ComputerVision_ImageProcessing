I=imread('HeadCT.bmp');
A=rgb2gray(I);
G=edge(A,'sobel');
GX=edge(A,'sobel','horizontal');
GY=edge(A,'sobel','vertical');


s(1)=subplot(2,2,1);
imshow(I);
s(2)=subplot(2,2,2);
imshow(G);
s(3)=subplot(2,2,3);
imshow(GX);
s(4)=subplot(2,2,4);
imshow(GY);

title(s(1),'Original');
title(s(2),'G');
title(s(3),'Gx');
title(s(4),'Gy');