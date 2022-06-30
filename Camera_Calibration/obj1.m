function f = obj1(Pcg_prime)
global Pg12
global Pc12
global Pg23
global Pc23
%§¡¤è»~®t
f=((Pg12(2)+Pc12(2))*Pcg_prime(3)-(Pc12(3)+Pg12(3))*Pcg_prime(2)-(Pc12(1)-Pg12(1)))^2+((Pg12(3)+Pc12(3))*Pcg_prime(1)-(Pc12(1)+Pg12(1))*Pcg_prime(3)-(Pc12(2)-Pg12(2)))^2+((Pg12(1)+Pc12(1))*Pcg_prime(2)-(Pc12(2)+Pg12(2))*Pcg_prime(1)-(Pc12(3)-Pg12(3)))^2+((Pg23(2)+Pc23(2))*Pcg_prime(3)-(Pc23(3)+Pg23(3))*Pcg_prime(2)-(Pc23(1)-Pg23(1)))^2+((Pg23(3)+Pc23(3))*Pcg_prime(1)-(Pc23(1)+Pg23(1))*Pcg_prime(3)-(Pc23(2)-Pg23(2)))^2+((Pg23(1)+Pc23(1))*Pcg_prime(2)-(Pc23(2)+Pg23(2))*Pcg_prime(1)-(Pc23(3)-Pg23(3)))^2;
end