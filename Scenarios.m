%Run this code after Test 2
%New reproduction number and quarantine strategy activation
lambda=0.01;
alpha2=alpha1;
epsi=lambda;
p=0.01
R0=betaF*A/((mu+p)*(mu+alpha1+lambda+rho))
Rbs=betaF*A/((mu+p)*(mu+alpha1+lambda+rho))-Sig2/(2*(mu+alpha1+lambda+rho))
[S,I,Q,R]=Modell(A,betaF,mu,alpha1,alpha2,lambda,rho,epsi,p,n,tf,0,0,0,0,0,0,0,0);
[St,It,Qt,Rt]=Modell(A,betaF,mu,alpha1,alpha2,lambda,rho,epsi,p,n,tf,Sig1,Sig1*1e-10,Sig2,Sig2*2e-5,Sig2,Sig2*2e-5,Sig4,Sig4*1e-10);

 t = 1:n;
figure(1)
 ax(1) = subplot(4,1,1);
plot(t,S(t),'r',t,Sr(t),'o',t,St(t),'b')
title('Susceptibles')
ylabel('S(t)')

 ax(2) = subplot(4,1,2);
plot(t,I(t),'r',t,Ir(t),'o',t,It(t),'b')
title('Infected')
ylabel('I(t)')

 ax(3) = subplot(4,1,3);
plot(t,Q(t),'r',t,Qt(t),'b')
 title('Quarantine')
 ylabel('Q(t)')
  ax(4) = subplot(4,1,4);
plot(t,R(t),'r',t,Rr(t),'o',t,Rt(t),'b')
 title('Recovered')
 ylabel('R(t)')
 h = legend ('Deterministic Scenario','Real Data','Stochastic Scenario');
 L1=legend (h, "location", "northeast");
 %L1=legend('Deterministic Scenario','Real Data','Stochastic Scenario');
set(L1,'fontsize',10,'fontweight','bold')
saveas(gca,sprintf('scenarionQ.eps',1000),'epsc');