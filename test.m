clear
clc
%for k=1:100
format long
%s	=1;
%%%%%%%%%%%%%%%%%%%%%%%% Death rates %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Given data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu=	7.8/(1000*12*30);
A=38067913*mu;
alpha1= 0.023112808955347;
alpha2=0;
epsi=0;
R0=1.24;
rhoF=0;
epsiF=0;
lambda=0;
n=61;
p=0.004;
%delta=0.04;
%%%%%%%%%%%%%%%%%%%%%%%% Values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% To estimate
beta	=9e-1:1e-4:9.9e-1;
%beta	=0:1e-6:0.0015382;
%beta=0.000034781;
tf=5;
rho=0.99:0.001:1;
SzBeta=size(beta);
Szrho=size(rho);
Y0=10000000000000000000000000;
[Sr,Ir,Qr,Rr]=Realdata(n);
rhoF=0;
%[Sr,Ir,Qr,Rr]=transpose([Str,Itr,Qtr,Rtr]);
betaF=0;
for j=1 : Szrho(2)
  for i=1 : SzBeta(2)
  %  rho=(beta(i)*A-R0*(mu+alpha1+lambda))/R0;
            %Model(A,beta,   mu,alpha1,alpha2,delta, gamma1,gamma2,p,n,tf,sig11,sig12,sig21,sig22,sigma31, sig32,sig41,sig42)
   [S,I,Q,R]=Model(A,beta(i),mu,alpha1,alpha2,lambda,rho(j),epsi  ,p,n,tf,0,    0,     0,     0,    0,   0,  0,0);
   [Y]=Diff(S,I,Q,R,Sr,Ir,Qr,Rr,n);
    if (Y<=Y0)
    betaF=beta(i);
    rhoF=rho(j);
    Y0=Y;
    betaF
    rhoF
    Y0
    end
  end
end
[S,I,Q,R]=Model(A,betaF,mu,alpha1,alpha2,lambda,rhoF,epsi,p,n,tf,0,0,0,0,0,0,0,0);
betaF
R0=betaF*A/((mu+0.0007)*(mu+alpha1+lambda))
%R0=betaF*K/(mu+alpha1+lambda+rhoF)
t = 1:n;
figure(1)
 ax(1) = subplot(4,1,1);
plot(t,S(t),'k')
title('Susceptibles')
ylabel('S(t)')

 ax(2) = subplot(4,1,2);
plot(t,I(t),'k')
title('Infected')
ylabel('I(t)')

 ax(3) = subplot(4,1,3);
plot(t,Q(t),'k')
 title('Quarantine')
 ylabel('Q(t)')
  ax(4) = subplot(4,1,4);
plot(t,R(t),'k')
 title('Recovered')
 ylabel('R(t)')

 t = 1:n;
figure(1)
 ax(1) = subplot(4,1,1);
plot(t,S(t),'k',t,Sr(t),'r')
title('Susceptibles')
ylabel('S(t)')

 ax(2) = subplot(4,1,2);
plot(t,I(t),'k',t,Ir(t),'r')
title('Infected')
ylabel('I(t)')

 ax(3) = subplot(4,1,3);
plot(t,Q(t),'k',t,Qr(t),'r')
 title('Quarantine')
 ylabel('Q(t)')
  ax(4) = subplot(4,1,4);
plot(t,R(t),'k',t,Rr(t),'r')
 title('Recovered')
 ylabel('R(t)')
 L1=legend('Theoritical Scenario','Real Data');
set(L1,'fontsize',10,'fontweight','bold','Location','best')