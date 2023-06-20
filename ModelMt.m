function [S,I,Q,R]=ModelMt(A,beta,mu,alpha1,alpha2,lambda,rho,epsi,p,n,tf,sig11,sig12,sig21,sig22,sig31,sig32,sig41,sig42)
%%%%%%%%%%%%%%%%%%%%%% Initial values %%%%%%%%%%%%%%%%%%%%%%%%%%%%
s0=35435449;
i0=49565;
q0=0;
a=0.99;
r0=1637215;
S(1)=s0;I(1)=i0;
Q(1)=q0;R(1)=r0;
r1=1e-6;
t0=0;
%tf=5;
h=(tf-t0)/n;
t=[0:h:tf];
%%%%%%%%%%%%%%%%%%%%%%%%%% Systeme dynamique %%%%%%%%%%%%%%%%%%%%%%%%%
for i=1 : n
  S(i+1) = S(i)+(A-(mu+p*(1-exp(-i)))*S(i)-beta*(a+(1-a)*exp(-0.05*i))*S(i)*I(i)/(1+r1*I(i)))*h+S(i)*(sig11+sig12*S(i))*sqrt(h)*randn;
  %I(i+1) = I(i)+(s -p*Xs(i)-mu*Xs(i)-beta*Xs(i)*Ys(i)/(1+r1*Xs(i)+r2*Ys(i)+r3*Xs(i)*Ys(i))+p*(Xs(i)-(Xs(i)-Xs(i-1))/2)*exp(-mu*0.5)+gamma*(Ys(i)-(Ys(i)-Ys(i-1))/2)*exp(-mu*0.5)+epsi*(Z(i)-(Z(i)-Z(i-1))/2)*exp(-mu*0.5))*h+sig1*Xs(i)*sqrt(h)*randn;
  I(i+1) = I(i) +(beta*(a+(1-a)*exp(-0.05*i))*S(i)*I(i)/(1+r1*I(i))-(mu+alpha1+lambda+rho)*I(i))*h+I(i)*(sig21+sig22*I(i))*sqrt(h)*randn;
  %Ys(i+1) = Ys(i) +(beta*Xs(i)*Ys(i)/(1+r1*Xs(i)+r2*Ys(i)+r3*Xs(i)*Ys(i))-(mu+alpha1+delta+gamma)*Ys(i))*h+sig2*Ys(i)*sqrt(h)*randn;
  Q(i+1) = Q(i) +(lambda*I(i)-(mu+alpha2+epsi)*Q(i))*h+Q(i)*(sig31+sig32*Q(i))*sqrt(h)*randn;
  %Zs(i+1) = Zs(i) +(gamma*Ys(i)-(mu+alpha2+epsi)*Zs(i))*h+sig3*Zs(i)*sqrt(h)*randn;
  R(i+1) = R(i) +(rho*I(i)+p*(1-exp(-i))*S(i)+epsi*Q(i)-mu*R(i))*h+R(i)*(sig41+sig42*Q(i))*sqrt(h)*randn;
 end
endfunction
