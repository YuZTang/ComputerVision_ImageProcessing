I=imread('HW3.bmp');
gray_level=rgb2gray(I);
contrast=immultiply(gray_level,3); 
level=graythresh(contrast);
bw=im2bw(contrast,level); 
[B,L]= bwboundaries(~bw,'noholes');

out=B{1};
x0=out(:,2);
y0=out(:,1);
x=[x0;x0];
y=[y0;y0];

n=length(x);
s=linspace(-n/2,n/2,n);
sigma=5;
g0=1/sqrt(2*pi*sigma^2)*exp(-s.^2/(2*sigma^2));
g=[g0 g0]';
X=conv(x,g,'same'); X=X(1:end/2);
Y=conv(y,g,'same');Y=Y(1:end/2);

figure
s(1)=subplot(2,3,1);
plot(x);
s(2)=subplot(2,3,2);
plot(g);
s(3)=subplot(2,3,3);
plot(X);
s(4)=subplot(2,3,4);
plot(y);
s(5)=subplot(2,3,5);
plot(g);
s(6)=subplot(2,3,6);
plot(Y);

title(s(1),'x');
title(s(2),'g');
title(s(3),'X');
title(s(4),'y');
title(s(5),'g');
title(s(6),'Y');

X_dot=diff(X);
Y_dot=diff(Y);
X_double_dot=diff(X_dot);
Y_double_dot=diff(Y_dot);
X_dot(1)=[];
Y_dot(1)=[];
K=X_dot.*Y_double_dot-Y_dot.*X_double_dot;

figure
% c(1)=subplot(2,1,1);
% plot(K);
% title(c(1),'K');
% 
KK=smooth(K);
% c(2)=subplot(2,1,2);
% plot(KK);
% title(c(2),'KK');

plot(K,'r');
hold on;
plot(KK,'b')

[pks,loc]=findpeaks(KK,'SortStr','descend','Npeaks',6);
findpeaks(KK,'SortStr','descend','Npeaks',6);
figure
imshow(bw);
hold on
h = scatter(X(loc),Y(loc),50,'r','filled')


