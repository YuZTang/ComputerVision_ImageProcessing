I=imread('HeadCT.bmp');

gaussian1=fspecial('gaussian',200,1);
gaussian2=fspecial('gaussian',200,2);
dog=gaussian1-gaussian2;

DOG=imfilter(I,dog);

s(1)=subplot(2,1,1);
imshow(I);
s(2)=subplot(2,1,2);
imshow(DOG);

title(s(1),'Original');
title(s(2),'DoG');
