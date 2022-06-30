clear;clc

%%世界座標參數
l=0.965*2.54*10;%一個格子的邊長 (m)
Xw=zeros(10,1);
for i=1:10
Xw(i)=0.5*l+(i-1)*l;
end

Yw=zeros(7,1);
for i=1:7
Yw(i)=0.5*l+(i-1)*l;
end

XYZw=zeros(35,3);
for j=1:5
for i=1:4
XYZw(i+7*(j-1),1)=Xw(1+2*(j-1));
end
end

%此為作為被選為校正點的格子的形心的世界座標矩陣
XYZw(1:4,1)=Xw(1);
XYZw(5:7,1)=Xw(2);
XYZw(8:11,1)=Xw(3);
XYZw(12:14,1)=Xw(4);
XYZw(15:18,1)=Xw(5);
XYZw(19:21,1)=Xw(6);
XYZw(22:25,1)=Xw(7);
XYZw(26:28,1)=Xw(8);
XYZw(29:32,1)=Xw(9);
XYZw(33:35,1)=Xw(10);
for i=1:5
XYZw(1+(i-1)*7,2)=Yw(1);
XYZw(2+(i-1)*7,2)=Yw(3);
XYZw(3+(i-1)*7,2)=Yw(5);
XYZw(4+(i-1)*7,2)=Yw(7);
XYZw(5+(i-1)*7,2)=Yw(2);
XYZw(6+(i-1)*7,2)=Yw(4);
XYZw(7+(i-1)*7,2)=Yw(6);
end



%%尋找影像座標
im=imread('cropped_calibration.jpg');%讀入目標影像
gray_level=rgb2gray(im);
contrast=immultiply(gray_level,1.2);%增強對比以利後續尋找形心
level=graythresh(contrast);
bw=im2bw(contrast,level); 
imshow(bw);
bw=~bw;
s = regionprops(bw,'centroid');%尋找形心
hold on;
image_coordinate=struct2cell(s);
%將形心標示在影像上
for k = 1:length(image_coordinate)
   boundary = image_coordinate{k};
   scatter(boundary(:,1), boundary(:,2), 'r') %因為矩陣顯示的順序跟直角坐標系不同 故顛倒
end
scatter(0,0,'y');

%%stage 1
%從題目上已給的參數
Ncx=608; Ncy=391;
dx=4.5/Ncx; dy=2.9/Ncy;
Nfx=752; Nfy=480;
dx_prime=Ncx/Nfx*dx; dy_prime=Ncy/Nfy*dy;
Wx=229;
Wy=62;
Cx=Nfx/2; Cy=Nfy/2;

Xd=zeros(6,1);
Yd=zeros(6,1);
%被選出的五個要校正的點的世界座標與影像作標的相對應的index
d_index=[2 8 21 32 36];
w_index=[1 4 20 33 35];
%Xd Yd的公式
for i=1:5
Xd(i)=(image_coordinate{d_index(i)}(1)+Wx-Cx)*dx_prime;
Yd(i)=(image_coordinate{d_index(i)}(2)+Wy-Cy)*dy_prime;
end

A=zeros(5,5);
b=zeros(5,1);
mu=zeros(5,1);
%代入A*mu=b的公式
for i=1:5
A(i,1)=XYZw(w_index(i),1)*Yd(i);
A(i,2)=XYZw(w_index(i),2)*Yd(i);
A(i,4)=-XYZw(w_index(i),1)*Xd(i);
A(i,5)=-XYZw(w_index(i),2)*Xd(i);
A(i,3)=Yd(i);
end
for i=1:5
b(i)=Xd(i);
end
mu=inv(A)*b;

%計算Ty^2
Sr=mu(1)^2+mu(2)^2+mu(4)^2+mu(5)^2;
Ty_square=((Sr-(Sr^2-4*(mu(1)*mu(5)-mu(4)*mu(2))^2)^0.5))/(2*(mu(1)*mu(5)-mu(4)*mu(2))^2)
Ty_square_2=1/Sr

%選擇距離相機座標原點最遠的校正點
Xfi_away=image_coordinate{36}(1);
Yfi_away=image_coordinate{36}(2);
Xwi_away=XYZw(35,1);
Ywi_away=XYZw(35,2);
Zwi_away=XYZw(35,3);

%判斷Ty的正負
Ty=Ty_square^0.5;%先以正去計算
r=zeros(5,1);
for i=1:5
r(i)=mu(i)*Ty;
end
x=r(1)*Xwi_away+r(2)*Ywi_away+r(3);
y=r(4)*Xwi_away+r(5)*Ywi_away+Ty;
Tx=r(3);
if x/Xwi_away>0 & y/Ywi_away>0 %若最遠的校正點的x與Xw同號且y與Yw同號，則Ty>0，其餘狀況Ty<0
Ty=Ty
else
Ty=-Ty
end

%將上列元素代入R公式中對應之位置以求得R
R=zeros(3,3);
s=-sign(r(1)*r(4)+r(2)*r(5));
R(1,1)=r(1);
R(1,2)=r(2);
R(1,3)=(1-r(1)^2-r(2)^2)^0.5;
R(2,1)=r(4);
R(2,2)=r(5);
R(2,3)=s*(1-r(4)^2-r(5)^2)^0.5;
R(3,:)=cross(R(1,:),R(2,:))/norm(cross(R(1,:),R(2,:)));

%為了計算A'*x'=b'，須有至少三個校正點
w_index_for_f=[1 20 35]; %選取三個校正點的世界座標位置
xi=zeros(3,1);

%代入x公式
for i=1:3
x(i)=R(1,1)*XYZw(w_index_for_f(i),1)+R(1,2)*XYZw(w_index_for_f(i),2)+Tx;
end

A_prime=zeros(3,3);
x_prime=zeros(3,1);
b_prime=zeros(3,1);
%根據A'矩陣內容填入相對應的元素形成A'
for i=1:3
A_prime(i,1)=x(i);
end
A_prime(1,2)=(Xd(1)^2+Yd(1)^2)*x(1);
A_prime(2,2)=(Xd(3)^2+Yd(3)^2)*x(2);
A_prime(3,2)=(Xd(5)^2+Yd(5)^2)*x(3);
A_prime(1,3)=-Xd(1);
A_prime(2,3)=-Xd(3);
A_prime(3,3)=-Xd(5);

%根據b'矩陣內容填入相對應的元素形成b'
b_prime(1)=(R(3,1)*XYZw(w_index_for_f(1),1)+R(3,2)*XYZw(w_index_for_f(1),2))*Xd(1);
b_prime(2)=(R(3,1)*XYZw(w_index_for_f(2),1)+R(3,2)*XYZw(w_index_for_f(2),2))*Xd(3);
b_prime(3)=(R(3,1)*XYZw(w_index_for_f(3),1)+R(3,2)*XYZw(w_index_for_f(3),2))*Xd(5);

%A'*x'=b' 故 x'=inv(A')*b'
x_prime=inv(A_prime)*b_prime;
% x'=[f f*k1 Tz]
Tz=x_prime(3);
R
T=[ Tx Ty Tz]
f=x_prime(1)
k1=x_prime(2)/f
