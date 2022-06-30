function ff = obj2(y)
global Rcg
global Tc12
global Tc23
global Tg12
global Tg23
global Rg12
global Rg23
%§¡¤è»~®t
ff=((Rg12(1)-1)*y(1)+Rg12(4)*y(2)+Rg12(7)*y(3)-(Rcg(1)*Tc12(1)+Rcg(4)*Tc12(2)+Rcg(7)*Tc12(3)-Tg12(1)))^2+((Rg23(1)-1)*y(1)+Rg23(4)*y(2)+Rg23(7)*y(3)-(Rcg(1)*Tc23(1)+Rcg(4)*Tc23(2)+Rcg(7)*Tc23(3)-Tg23(1)))^2+((Rg12(2))*y(1)+(Rg12(5)-1)*y(2)+Rg12(8)*y(3)-(Rcg(2)*Tc12(1)+Rcg(5)*Tc12(2)+Rcg(8)*Tc12(3)-Tg12(2)))^2+((Rg23(2))*y(1)+(Rg23(5)-1)*y(2)+Rg23(8)*y(3)-(Rcg(2)*Tc23(1)+Rcg(5)*Tc23(2)+Rcg(8)*Tc23(3)-Tg23(2)))^2+((Rg12(3))*y(1)+(Rg12(6))*y(2)+(Rg12(9)-1)*y(3)-(Rcg(3)*Tc12(1)+Rcg(6)*Tc12(2)+Rcg(9)*Tc12(3)-Tg12(3)))^2+((Rg23(3))*y(1)+(Rg23(6))*y(2)+(Rg23(9)-1)*y(3)-(Rcg(3)*Tc23(1)+Rcg(6)*Tc23(2)+Rcg(9)*Tc23(3)-Tg23(3)))^2;

end