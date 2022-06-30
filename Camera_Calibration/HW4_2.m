clear;clc;
global Rcg
global Tc12
global Tc23
global Tg12
global Tg23
global Rg12
global Rg23
global Pg12
global Pg23
global Pc12
global Pc23

%讀入題目已給資訊並計算Hc12 Hc23
load('hand_eye_data.mat')
Hc12=Hc2*inv(Hc1);
Hc13=Hc3*inv(Hc1);
Hc23=Hc3*inv(Hc2);

%Compute Rc12 Rc23 Tc12 Tc23
Rc12=Hc12(1:3,1:3)
Tc12=Hc12(1:3,4)
Rc23=Hc23(1:3,1:3)
Tc23=Hc23(1:3,4)

Tg12=Hg12(1:3,4);
Tg23=Hg23(1:3,4);

%Compute (n,theda) for Rc12 Rc23 Rg12 Rg23
Rg12=Hg12(1:3,1:3);
Rg23=Hg23(1:3,1:3);

Theda_Rc12=acos(0.5*(Rc12(1,1)+Rc12(2,2)+Rc12(3,3)-1))
if Theda_Rc12==0 | Theda_Rc12==pi %若theda=0 or pi, 則n=[0 0 0]
    n_Rc12=[0 0 0]
else
    n_Rc12=[Rc12(3,2)-Rc12(2,3) Rc12(1,3)-Rc12(3,1) Rc12(2,1)-Rc12(1,2)]/2/sin(Theda_Rc12)
end

Theda_Rc23=acos(0.5*(Rc23(1,1)+Rc23(2,2)+Rc23(3,3)-1))
if Theda_Rc23==0 | Theda_Rc23==pi %若theda=0 or pi, 則n=[0 0 0]
    n_Rc23=[0 0 0]
else
    n_Rc23=[Rc23(3,2)-Rc23(2,3) Rc23(1,3)-Rc23(3,1) Rc23(2,1)-Rc23(1,2)]/2/sin(Theda_Rc23)
end
 
Theda_Rg12=acos(0.5*(Rg12(1,1)+Rg12(2,2)+Rg12(3,3)-1))
if Theda_Rg12==0 | Theda_Rg12==pi %若theda=0 or pi, 則n=[0 0 0]
    n_Rg12=[0 0 0]
else
    n_Rg12=[Rg12(3,2)-Rg12(2,3) Rg12(1,3)-Rg12(3,1) Rg12(2,1)-Rg12(1,2)]/2/sin(Theda_Rg12)
end

Theda_Rg23=acos(0.5*(Rg23(1,1)+Rg23(2,2)+Rg23(3,3)-1))
if Theda_Rg23==0 | Theda_Rg23==pi %若theda=0 or pi, 則n=[0 0 0]
    n_Rg23=[0 0 0]
else
    n_Rg23=[Rg23(3,2)-Rg23(2,3) Rg23(1,3)-Rg23(3,1) Rg23(2,1)-Rg23(1,2)]/2/sin(Theda_Rg23)
end

%Compute Pc12 Pc23 Pg12 Pg23
Pc12=2*sin(0.5*Theda_Rc12)*n_Rc12
Pc23=2*sin(0.5*Theda_Rc23)*n_Rc23
Pg12=2*sin(0.5*Theda_Rg12)*n_Rg12
Pg23=2*sin(0.5*Theda_Rg23)*n_Rg23
Pc12=Pc12'; %此處要注意Pr向量為直的，故轉置，否則會影響其代入paper中(10)式的運算結果
Pc23=Pc23';
Pg12=Pg12';
Pg23=Pg23';

%Check Rg12,Rg23 by (8),(10) in [2],and comparing with those given in the data
Rg12_check_8=[n_Rg12(1)^2+(1-n_Rg12(1)^2)*cos(Theda_Rg12),n_Rg12(1)*n_Rg12(2)*(1-cos(Theda_Rg12))-n_Rg12(3)*sin(Theda_Rg12), n_Rg12(1)*n_Rg12(3)*(1-cos(Theda_Rg12))+n_Rg12(2)*sin(Theda_Rg12) ;
n_Rg12(1)*n_Rg12(2)*(1-cos(Theda_Rg12))+n_Rg12(3)*sin(Theda_Rg12), n_Rg12(2)^2+(1-n_Rg12(2)^2)*cos(Theda_Rg12), n_Rg12(2)*n_Rg12(3)*(1-cos(Theda_Rg12))-n_Rg12(1)*sin(Theda_Rg12);
n_Rg12(1)*n_Rg12(3)*(1-cos(Theda_Rg12))-n_Rg12(2)*sin(Theda_Rg12),n_Rg12(2)*n_Rg12(3)*(1-cos(Theda_Rg12))+n_Rg12(1)*sin(Theda_Rg12),n_Rg12(3)^2+(1-n_Rg12(3)^2)*cos(Theda_Rg12)];

Check_Rg12_by_8=Rg12-Rg12_check_8


skew_Pg12=[0 -Pg12(3) Pg12(2); Pg12(3) 0 -Pg12(1); -Pg12(2) Pg12(1) 0];
Rg12_check_10=(1-0.5*norm(Pg12)^2)*eye(3)+0.5*(Pg12*Pg12'+((4-norm(Pg12)^2)^0.5)*skew_Pg12);
Check_Rg12_by_10=Rg12-Rg12_check_10


Rg23_check_8=[n_Rg23(1)^2+(1-n_Rg23(1)^2)*cos(Theda_Rg23),n_Rg23(1)*n_Rg23(2)*(1-cos(Theda_Rg23))-n_Rg23(3)*sin(Theda_Rg23), n_Rg23(1)*n_Rg23(3)*(1-cos(Theda_Rg23))+n_Rg23(2)*sin(Theda_Rg23) ;
n_Rg23(1)*n_Rg23(2)*(1-cos(Theda_Rg23))+n_Rg23(3)*sin(Theda_Rg23), n_Rg23(2)^2+(1-n_Rg23(2)^2)*cos(Theda_Rg23), n_Rg23(2)*n_Rg23(3)*(1-cos(Theda_Rg23))-n_Rg23(1)*sin(Theda_Rg23);
n_Rg23(1)*n_Rg23(3)*(1-cos(Theda_Rg23))-n_Rg23(2)*sin(Theda_Rg23),n_Rg23(2)*n_Rg23(3)*(1-cos(Theda_Rg23))+n_Rg23(1)*sin(Theda_Rg23),n_Rg23(3)^2+(1-n_Rg23(3)^2)*cos(Theda_Rg23)];

RCheck_Rg23_by_8=Rg23-Rg23_check_8
 
skew_Pg23=[0 -Pg23(3) Pg23(2); Pg23(3) 0 -Pg23(1); -Pg23(2) Pg23(1) 0];
Rg23_check_10=(1-0.5*norm(Pg23)^2)*eye(3)+0.5*(Pg23*Pg23'+(4-norm(Pg23)^2)^0.5*skew_Pg23);
Check_Rg23_by_10=Rg23-Rg23_check_10



% Use procedure in [2] to compute Pcg,[Rcg] and Tcg
x01=[1 1 1]; %給定任意初始值
[x,fval,exitflag,output] = fmincon('obj1',x01,[],[]);
Pcg_prime=x';
Theda_Rgc=2*atan(norm(Pcg_prime));
Pcg=2*Pcg_prime/((1+norm(Pcg_prime)^2)^0.5)

skew_Pcg=[0 -Pcg(3) Pcg(2); Pcg(3) 0 -Pcg(2);-Pcg(2) Pcg(1) 0];
Rcg=(1-0.5*norm(Pcg)^2)*eye(3)+0.5*(Pcg*Pcg'+(4-norm(Pcg)^2)^0.5*skew_Pcg)

x02=[10  10 10];%給定任意初始值
[x2,fval2,exitflag2,output2] = fmincon('obj2',x02,[],[]);
Tcg=x2'