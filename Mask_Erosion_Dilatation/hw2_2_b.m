I=imread('Fig 2 (c).jpg');
I3=medfilt2(I,[3 3]);
I11=medfilt2(I,[11 11]);

s1=subplot(1,2,1);
imshow(I3);
s2=subplot(1,2,2);
imshow(I11);

title(s1,'3*3');
title(s2,'11*11');