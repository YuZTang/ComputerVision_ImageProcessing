I=imread('pollen.bmp');
rows=size(I,1);
columns=size(I,2);

%% 計算遮罩時邊緣的地方補零
new=zeros(rows+2,columns+2);
for i=1:rows
    for j=1:columns
        new(i+1,j+1)=I(i,j);
    end
end
%%  sobel計算
Gx=[-1 -2 -1;0 0 0 ;1 2 1];
Gy=[-1 0 1;-2 0 2;-1 0 1];
sobel=zeros(rows,columns);
direction=zeros(rows,columns);
for m=1:rows
    for n=1:columns
        X=sum(sum(Gx.*new(m:m+2,n:n+2)));
        Y=sum(sum(Gy.*new(m:m+2,n:n+2)));
        sobel(m,n)=sqrt(X^2+Y^2);
        direction(m,n)=atan(Y/X);
    end
end

%% answer
sobel(3,2)
direction(3,2)