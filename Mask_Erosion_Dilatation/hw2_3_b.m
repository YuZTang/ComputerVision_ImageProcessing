I=imread('Fig 3(a).png');
SE1=strel('square',3);
J=imdilate(I,SE1);

SE2=strel([0 1 0;1 1 1 ;0 1 0]);
K=imdilate(I,SE2);

s1=subplot(2,2,1);
imshow(I);
title(s1,'Original')

s2=subplot(2,2,2);
imshow(J);
title(s2,'square element');

s3=subplot(2,2,4);
imshow(K);
title(s3,'cross element');
