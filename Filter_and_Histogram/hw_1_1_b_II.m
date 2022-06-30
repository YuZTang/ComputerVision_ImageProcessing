I=imread('pollen.bmp');
J=histeq(I);
subplot(2,2,1); imhist(I);
subplot(2,2,2); imhist(J);
subplot(2,2,3);imshow(I);
subplot(2,2,4);imshow(J);