%IssT=0;
tf=68;
K=0;
delta=0;
for i=2:2
n=80;
[Sr,Ir,Qr,Rr]=RealdataF(n);
[S,I,Q,R]=Modell(A,betaF,mu,alpha2,alpha3,delta,gamma2,gamma3,p,n,tf,0,0,0,0,0,0,0,0);
%R0=betaF*K/(mu+alpha1+lambda+rhoF)
 t = 1:n;
figure(1)
 ax(1) = subplot(3,1,1);
plot(t,S(t),'k',t,Sr(t),'o')
title('Susceptibles')
ylabel('S(t)')
L1=legend(["Theoretical \n Scenario","Real Data"],'location','southwest');
% legend left
set(L1,'fontsize',9,'fontweight','bold')
 ax(2) = subplot(3,1,2);
plot(t,I(t),'k',t,Ir(t),'o')
title('Infected')
ylabel('I(t)')

% ax(3) = subplot(4,1,3);
%plot(t,Q(t),'k',t,Qr(t),'o')
% title('Quarantine')
% ylabel('Q(t)')
  ax(3) = subplot(3,1,3);
plot(t,R(t),'k',t,Rr(t),'o')
 title('Recovered')
 ylabel('R(t)')
 xlabel ("Time");
 
saveas(gca,'figure1.eps','epsc');
%%%%%%%%%%%%%%  Figure 2    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(i)
[Sig1, Sig2, Sig3, Sig4]=Volatility(S,I,Q,R,Sr,Ir,Qr,Rr,n)
[Ss,Is,Qs,Rs]=Modell(A,betaF,mu,alpha2,alpha3,delta,gamma2,gamma3,p,n,tf,0,0,Sig2/2,0,0,0,0,0);
[Sss,Iss,Qss,Rss]=Modell(A,betaF,mu,alpha2,alpha3,delta,gamma2,gamma3,p,n,tf,0,0,Sig2/2,Sig2*2e-10,0,0,0,0);
%Ipr=Ir;
t1=1:n;
t2=1:n+1;
dI=Sig2*I;
dI2=3*Sig2*I;
IU=(I+dI)';
ID=(I-dI)';
IU2=(I+dI2)';
ID2=(I-dI2)';
T = [ t2 fliplr(t2) ];
Y = [  IU fliplr(ID)];
Yp = [ IU2 fliplr(ID2) ];
col = [1 0.5 0.5];
col2 = [1 0.4 0.5];
ay(1)=subplot(1,1,1);
%patch (T,Yp,'facecolor',col2,'edgecolor',col2); hold on;
%patch (T,Y,'facecolor',col,'edgecolor',col); hold on;
plot(t1,I(t1),'k',t1,Is(t1),'c',t1,Iss(t1),'b',t1,Ir(t1),'o')
line ("xdata",[60,60], "ydata",[0,100000], "linewidth", 3)
title('Infected')
ylabel('I(t)')
xlabel ("Time");
 L1=legend('3 times Volatility','Volatility','SIQR','Stochastic SIQR','Stochastic Higher Order SIQR','Real Data');
saveas(gca,sprintf('figure %i.eps',i),'epsc');
%K=size(IssT,2);
  for j=1:length(Iss)
  IssT(j+K)=Iss(j);
end 
K=length(IssT);
end
figure(200)
hist(IssT,15);
saveas(gca,sprintf('figure %i.eps',5000),'epsc');