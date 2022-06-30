I=imread('HeadCT.bmp');
rows=size(I,1);
columns=size(I,2);
new=zeros(rows+2,rows+2);
for i=1:rows
    for j=1:columns
        new(i+1,j+1)=I(i,j);
    end
end

Gx=[-1 -2 -1;0 0 0 ;1 2 1];
Gy=[-1 0 1;-2 0 2;-1 0 1];
sobel=zeros(rows,columns);
direction=zeros(rows,columns);
gx=zeros(rows,columns);
gy=zeros(rows,columns);

for m=1:rows
    for n=1:columns
        X=sum(sum(Gx.*new(m:m+2,n:n+2)));
        Y=sum(sum(Gy.*new(m:m+2,n:n+2)));
        sobel(m,n)=sqrt(X^2+Y^2);
        gx(m,n)=X;
        gy(m,n)=Y;
        direction(m,n)=atan(Y/X);
    end
end
 