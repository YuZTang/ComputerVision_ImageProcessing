I=imread('Fig 3(a).png');
SE=strel('square',3);
J=imopen(I,SE);
K=imclose(I,SE);

s1=subplot(2,2,1);
imshow(I);
title(s1,'Original')

s2=subplot(2,2,2);
imshow(J);
title(s2,'Open');

s3=subplot(2,2,4);
imshow(K);
title(s3,'Close');
