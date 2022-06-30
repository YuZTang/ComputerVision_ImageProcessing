I=imread('nut_and_shell.bmp');
gray_level=rgb2gray(I);
contrast=immultiply(gray_level,3);
imhist(contrast);
level=graythresh(contrast);
bw=im2bw(contrast,level); 
bw=~bw;
figure
imshow(bw);
[B,L] = bwboundaries(bw,'noholes');%只要找外圍所以內部的洞不找
hold on
for k = 1:length(B)
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 5) %因為矩陣顯示的順序跟直角坐標系不同 故顛倒
end