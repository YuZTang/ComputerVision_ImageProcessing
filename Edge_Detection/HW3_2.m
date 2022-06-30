RGB = imread('HW3.bmp');
     I  = rgb2gray(RGB); % convert to intensity
     BW = edge(I,'canny'); % extract edges
     BW = BW(end:-1:1,1:1:end);
     theta = -90:0.5:(90-0.5);
     D = sqrt((size(BW,1) - 1)^2 + (size(BW,2) - 1)^2);
     rho = -ceil(D):0.5:ceil(D);
     houghMatrix = zeros(size(rho,2),size(theta,2));
     for i=1:size(BW,1)
         for j=1:size(BW,2)
             if(BW(i,j)==1)
                  for ii=1:size(theta,2)                  
                      rho1 = i*cosd(theta(1,ii)) + j*sind(theta(1,ii));
                      rhotemp = rho1 - floor(rho1);
                      if(rhotemp>(0.5+0.25))
                          rho1 = ceil(rho1);
                      elseif(rhotemp>0.25)
                          rho1 = floor(rho1) + 0.5;
                      else
                          rho1 = floor(rho1);
                      end
                      position = (rho1 - rho(1,1))/0.5;
                      houghMatrix(position+1,ii) = houghMatrix(position+1,ii) + 1;
                  end
             end
         end
     end
 [H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89.5);
 
imshow(imadjust(H/60)),'XData',T,'YData',R,...,'InitialMagnification','fit');
colormap(gca,hot);    


% Finding local maxima in Accumulator
AccumulatorbinaryMax = imregionalmax(houghMatrix/62);
[Potential_p Potential_teta] = find(AccumulatorbinaryMax == 1);
Accumulatortemp = houghMatrix - 40;
pdetect = [];tetadetect = [];
for cnt = 1:numel(Potential_p)
    if Accumulatortemp(Potential_p(cnt),Potential_teta(cnt)) >= 0
        pdetect = [pdetect;Potential_p(cnt)];
        tetadetect = [tetadetect;Potential_teta(cnt)];
    end
end
% Calculation of detected lines parameters(Radius & Angle).
pdetect = pdetect * 0.5;
tetadetect = tetadetect *0.5-0.5;
for n=1:6
x=linspace(0,1000);
y=cot(tetadetect(n))*-x+pdetect(n)/sin(tetadetect(n));
plot(y);
hold on;
end