r=imread('Fig 2 (e).png');
r=double(r)/255;

s1=subplot(2,2,1);
imshow(r)
title(s1,'Original');

c=0.5;
gamma1=0.4;
S=c*r.^gamma1;
s2=subplot(2,2,2);
imshow(S);
title(s2,'C=0.5,Gamma=0.4');

c=0.5;
gamma2=2.5;
S2=c*r.^gamma2;
s2=subplot(2,2,4);
imshow(S2);
title(s2,'C=0.5,Gamma=2.5');


R=double(r);
c=200;
gamma2=2.5;
S3=c*r.^gamma2;
s3=subplot(2,2,3);
imshow(S3/255);
title(s3,'C=200,Gamma=2.5¡A¤£¥ýÂk¨Ì');

