I=imread('Fig 2 (e).png');
I=double(I);
rows=size(I,1);
columns=size(I,2);

T=zeros(rows,columns,3);
for k=1:3
 for i=1:rows
    for j=1:columns
        if 0<=I(i,j,k) & I(i,j,k)<130 
            T(i,j,k)=I(i,j,k)*8/13;
            
        elseif I(i,j,k)>=130 & I(i,j,k)<170  
            T(i,j,k)=3*I(i,j,k)-310;
            
        elseif I(i,j,k)>=170 & I(i,j,k)<=255  
            T(i,j,k)=11/17*I(i,j,k)+90;
        end
        end
    end
end
s1=subplot(1,2,1);
imshow(I/255);
title(s1,'Original');

s2=subplot(1,2,2);
imshow(T/255);
title(s2,'Transformed');