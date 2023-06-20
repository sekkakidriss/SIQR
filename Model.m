function [S,I,Q,R]=Model(A,beta,mu,alpha1,alpha2,delta,gamma1,gamma2,p,n,tf,sig11,sig12,sig21,sig22,sig31,sig32,sig41,sig42)
%%%%%%%%%%%%%%%%%%%%%% Initial values %%%%%%%%%%%%%%%%%%%%%%%%%%%%
s0=35435449;
i0=49565;
q0=0;
r0=1637215;
S(1)=s0;
I(1)=i0;
Q(1)=q0;
R(1)=r0;
t0=0;
%tf=5;
h=(tf-t0)/n;
t=[0:h:tf];
mu2 = mu+alpha1+delta+gamma1; 
mu3 = mu+alpha2+gamma2;
f = @(x) x ./(1+0.001*x+0.005*x.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%% Systeme dynamique %%%%%%%%%%%%%%%%%%%%%%%%%
for i=1 : n
  S(i+1) = S(i) +h*(A-(mu+p*(1-exp(-i)))*S(i)-beta*S(i)* f(I(i))  )  + S(i)*(sig11+sig12*S(i))*sqrt(h)*randn;
 
  I(i+1) = I(i) +h*(beta*S(i)*f(I(i))-mu2*I(i))  +  I(i)*(sig21+sig22*I(i))*sqrt(h)*randn;
  
  Q(i+1) = Q(i) +h*(delta*I(i)-mu3*Q(i))  + Q(i)*(sig31+sig32*Q(i))*sqrt(h)*randn;
 
  R(i+1) = R(i) +h*(gamma1*I(i) +p*(1-exp(-i))*S(i)+gamma2*Q(i)-mu*R(i)) + R(i)*(sig41+sig42*Q(i))*sqrt(h)*randn;
 end
end
