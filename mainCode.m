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
epsi=0; %gamma2
R0=1.24;
rhoF=0; %gamma1
epsiF=0; %gamma2
lambda=0; %delta 
delta=0.04; %p
%%%%%%%%%%%%%%%%%%%%%%%% Values %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% To estimate
beta	= 0.000034781:1e-6:0.0015382;
rho=(beta*A-R0*(mu+alpha1+lambda))/R0;
%gamma=0.4;
%%%%%%%%%%%%%%%%%%%%%%% Volatilities %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% sig1= 0.3; sig2=0.4;sig3=0.4;
%%%%%%%%%%%%%%%%%%%%%%%% Reproduction Basic Rate %%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Discretisation %%%%%%%%%%%%%%%%%%%%%%%%
n=64;
Szrho=size(rho);
Szepsi=size(epsi);
SzBeta=size(beta);
[Sr,Ir,Qr,Rr]=Realdata(n);
Y0=1e14;
betaF=0;
tf=5;

n=length(Sr);
r=A ;% essai
K =2.94e-8 ;% beta 
gamma = alpha1;


for k=1 : Szepsi(2)
 for j=1 : Szrho(2)
  for i=1 : SzBeta(2)
             %Model(A,beta,mu,alpha1,alpha2,delta,gamma1,gamma2,p,n,tf,sig11,sig12,sig21,sig22,sig31,sig32,sig41,sig42)
  [S, I ,Q ,R]=Model(A,beta(i),mu,alpha1,alpha2,lambda,rho(j),epsi(k),delta,n,tf,0,0,0,0,0,0,0,0);
  [Y]=Diff(S,I,Q,R,Sr,Ir,Qr,Rr,n);
   if (Y<=Y0)
     betaF=beta(i)
     rhoF=rho(j)
     epsiF=epsi(k)
     Y0=Y
   end
  end
 end
end 
[S, I ,Q ,R]=Model(A,betaF,mu,alpha1,alpha2,lambda,rhoF,epsiF,delta,n,tf,0,0,0,0,0,0,0,0);
[Sig1, Sig2, Sig3, Sig4]=Volatility(S,I,Q,R,Sr,Ir,Qr,Rr,n)
%[Sr,Ir,Qr,Rr]=Realdata(n);
%[X,Y,Z,W]=Diff(S,I,Q,R,Sr,Ir,Qr,Rr,n);
R0=betaF*K/(mu+alpha1+lambda+rhoF)
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
set(L1,'fontsize',10,'fontweight','bold')
saveas(gca,'figure1.eps','epsc');
% savefig(h,sprintf('FIG%d.fig',k))
%end

%plot (t,x(t),'k',t,Xs(t),'r');
%plot (t,y(t),'k',t,Ys(t),'r');

%plot (t,z(t),'k',t,Zs(t),'r');
%xlabel ("time t");
%ylabel (ax(1), "time t");
%ylabel (ax(2), "Axis 2");
%plot (t,x(t),'r');

% ax(2) = subplot(1,1,2);
np=89;
tf1=7;
[Sp, Ip ,Qp ,Rp]=Model(A,betaF,mu,alpha1,alpha2,lambda,rhoF,epsiF,delta,np,tf1,0,0,0,0,0,0,0,0);
Ipr=xlsread('dataCovid.xlsx','Sheet1','B1:B90');
Qpr=xlsread('dataCovid.xlsx','Sheet1','C1:C90');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
%Ip=I;
%Ipr=Ir;
t1=1:89;
t2=1:90;
dI=9*Sig2*Ip;
dI2=5*Sig2*Ip;
T = [ t2 fliplr(t2) ];
Y = [ Ip-dI fliplr(Ip+dI) ];
Yp = [ Ip-dI2 fliplr(Ip+dI2) ];
col = [1 0.5 0.5];
col2 = [1 0.4 0.5];
ay(1)=subplot(1,1,1);
patch (T,Y,'facecolor',col,'edgecolor',col); hold on;
patch (T,Yp,'facecolor',col2,'edgecolor',col2); hold on;
plot(t1,Ip(t1),'k',t1,Ipr(t1),'r')
line ('xdata',[65,65], 'ydata',[0,60000], 'linewidth', 3)
title('Infected')
ylabel('I(t)')
saveas(gca,'figure2.eps','epsc');
figure(3)
%Qp=Q;
%Qpr=Qr;
%t2=1:79;
dQ=11*Sig3*Qp;
dQ2=6*Sig3*Qp;
%T = [ t1 fliplr(t1) ]
Y2 = [ Qp-dQ2 fliplr(Qp+dQ2) ];
Y1 = [ Qp-dQ fliplr(Qp+dQ) ];
col = [1 0.5 0.5];
col2 = [1 0.4 0.5];
az(1)=subplot(1,1,1);
patch (T,Y1,'facecolor',col,'edgecolor',col); hold on;
patch (T,Y2,'facecolor',col2,'edgecolor',col2); hold on;
plot(t1,Qp(t1),'k',t1,Qpr(t1),'r')
line ('xdata',[65,65], 'ydata',[0,40000], 'linewidth', 3)
title('Quarantine')
ylabel('Q(t)')
saveas(gca,'figure3.eps','epsc');