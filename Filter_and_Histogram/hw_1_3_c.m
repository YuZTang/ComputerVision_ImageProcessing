I=imread('nut_and_shell.bmp');
gray_level=rgb2gray(I);
contrast=immultiply(gray_level,3);
imhist(contrast);
level=graythresh(contrast);
bw=im2bw(contrast,level); 
bw=~bw;
figure
imshow(bw);
[B,L] = bwboundaries(bw,'noholes');%�u�n��~��ҥH�������}����
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 5) %�]���x�}��ܪ����Ǹ򪽨����Шt���P �G�A��
end