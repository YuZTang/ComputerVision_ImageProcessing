I=imread('nut_and_shell.bmp');
gray_level=rgb2gray(I);

imhist(gray_level);
bw_under=im2bw(I,0); %threshold=0
bw_between=im2bw(I,0.2); %threshold=50
bw_over=im2bw(I,1); %threshold=255

figure
s(1)=subplot(2,2,1);
imshow(I);
s(2)=subplot(2,2,2);
imshow(bw_under);
s(3)=subplot(2,2,3);
imshow(bw_between);
s(4)=subplot(2,2,4);
imshow(bw_over);

title(s(1),'Original');
title(s(2),'Under-estimated');
title(s(3),'Between');
title(s(4),'Over-estimated');