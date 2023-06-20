function [S,I,Q,R]=Modell(A,beta,mu,alpha2,alpha3,delta,gamma2,gamma3,p,n,tf,sig11,sig12,sig21,sig22,sig31,sig32,sig41,sig42)
%%%%%%%%%%%%%%%%%%%%%% Initial values %%%%%%%%%%%%%%%%%%%%%%%%%%%%
s0=35435449;
i0=49565;
q0=0;
r0=1637215;
S = zeros(n,1);
I = S;
Q = S;
R = S;

S(1)=s0;I(1)=i0;
Q(1)=q0;R(1)=r0;
t0=0;
%tf=5;
h=(tf-t0)/n;
t=[0:h:tf];
a=1;
%%%%%%%%%%%%%%%%%%%%%%%%%% Systeme dynamique %%%%%%%%%%%%%%%%%%%%%%%%%
for i=1 : n
  M(i)=a+(1-a)*exp(-0.1*i);
  S(i+1) = S(i)+(A-(mu+p)*S(i)-beta*S(i)*I(i)*M(i))*h+S(i)*(sig11+sig12*S(i))*sqrt(h)*randn;
  %I(i+1) = I(i)+(s -p*Xs(i)-mu*Xs(i)-beta*Xs(i)*Ys(i)/(1+r1*Xs(i)+r2*Ys(i)+r3*Xs(i)*Ys(i))+p*(Xs(i)-(Xs(i)-Xs(i-1))/2)*exp(-mu*0.5)+gamma*(Ys(i)-(Ys(i)-Ys(i-1))/2)*exp(-mu*0.5)+gamma3*(Z(i)-(Z(i)-Z(i-1))/2)*exp(-mu*0.5))*h+sig1*Xs(i)*sqrt(h)*randn;
  I(i+1) = I(i) +(beta*S(i)*I(i)*M(i)-(mu+alpha2+delta+gamma2)*I(i))*h+I(i)*(sig21+sig22*I(i))*sqrt(h)*randn;
  %Ys(i+1) = Ys(i) +(beta*Xs(i)*Ys(i)/(1+r1*Xs(i)+r2*Ys(i)+r3*Xs(i)*Ys(i))-(mu+alpha2+delta+gamma)*Ys(i))*h+sig2*Ys(i)*sqrt(h)*randn;
  Q(i+1) = Q(i) +(delta*I(i)-(mu+alpha3+gamma3)*Q(i))*h+Q(i)*(sig31+sig32*Q(i))*sqrt(h)*randn;
  %Zs(i+1) = Zs(i) +(gamma*Ys(i)-(mu+alpha3+gamma3)*Zs(i))*h+sig3*Zs(i)*sqrt(h)*randn;
  R(i+1) = R(i) +(gamma2*I(i)+p*S(i)+gamma3*Q(i)-mu*R(i))*h+R(i)*(sig41+sig42*Q(i))*sqrt(h)*randn;
 end
end
