I=imread('salt_and_pepper_checker.bmp');
%% 建立遮罩 大小為400*400
h_1=fspecial('gaussian',400,1);
h_2=fspecial('gaussian',400,2);
h_5=fspecial('gaussian',400,5);

%% 套用遮罩
sigma_1=imfilter(I,h_1);
sigma_2=imfilter(I,h_2);
sigma_5=imfilter(I,h_5);

%%顯示
s(1)=subplot(2,2,1);
imshow(I);
s(2)=subplot(2,2,2);
imshow(sigma_1);
s(3)=subplot(2,2,3);
imshow(sigma_2);
s(4)=subplot(2,2,4);
imshow(sigma_5);

%%標題
title(s(1),'Original');
title(s(2),'sigma=1');
title(s(3),'sigma=2');
title(s(4),'sigma=5');