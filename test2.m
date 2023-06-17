clear
clc
%for k=1:100
format long
%s	=1;
%%%%%%%%%%%%%%%%%%%%%%%% Death rates %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% Given data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu=	7.8/(1000*12*30);
p=0.0003;
%%%%%A=38067913*(mu+ p);
%A=14000;
A=11398.40276166667;
alpha2= 0.011-mu;
alpha3=alpha2;
gamma3=0;
%R0=1.24;

delta=0;
n=60;
%delta=0.04;
%%%%%%%%%%%%%%%%%%%%%%%% Values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% To estimate
beta	=1e-9:1e-10:5e-8;
%beta	=0:1e-6:0.0015382;
%beta=0.000034781;
tf=50;
gamma2=1-mu-alpha2;
SzBeta=size(beta);
Szgamma2=size(gamma2);
Y0=10000000000000000000000000;
[Sr,Ir,Qr,Rr]=Realdata(n);
gamma2F=0;
%[Sr,Ir,Qr,Rr]=transpose([Str,Itr,Qtr,Rtr]);
betaF=0;
%for j=1 : Szgamma2(2)
 for i=1 : SzBeta(2)
  %  gamma2=(beta(i)*A-R0*(mu+alpha2+delta))/R0;
   [S,I,Q,R]=Modell(A,beta(i),mu,alpha2,alpha3,delta,gamma2,gamma3,p,n,tf,0,0,0,0,0,0,0,0);
        [Y]=Diff(S,I,Q,R,Sr,Ir,Qr,Rr,n);
        if (Y<=Y0)
        betaF=beta(i);
%    gamma2F=gamma2(j);
        Y0=Y;
        betaF
%    gamma2F
        Y0;
        end
 end

%end

[S,I,Q,R]=Modell(A,betaF,mu,alpha2,alpha3,delta,gamma2,gamma3,p,n,tf,0,0,0,0,0,0,0,0);
betaF
R0=betaF*A/((mu+p)*(mu+alpha2+delta+gamma2))
%R0=betaF*K/(mu+alpha2+delta+gamma2F)
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
 L1=legend('SIQR','Real Data','location','best');
set(L1,'fontsize',10,'fontweight','bold')