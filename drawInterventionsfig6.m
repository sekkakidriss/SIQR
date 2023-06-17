 % alpha2=alpha1;
 % alpha21=0;
 % epsi=9.768655243779863e-01;
 % epsi1=0;
 % lambda=9.768655243779863e-01-0.9;
 % lambda1=0;
 % rho1=9.768655243779863e-01;
 % rho=9.768655243779863e-01;
 p=0.0006;
 delta=0.001;
n=80;
%[Sr,Ir,Qr,Rr]=RealdataF(n);
[S,I,Q,R]=Modelll(A,betaF,mu,alpha2,alpha3,delta,gamma2,gamma3,p,n,tf,0,0,0,0,0,0,0,0);
[Ss,Is,Qs,Rs]=Modelll(A,betaF,mu,alpha2,alpha3,delta,gamma2,gamma3,p,n,tf,Sig1,Sig1*2e-10,Sig2,Sig2*2e-10,Sig2,Sig2*2e-10,Sig4,Sig4*2e-10);
%[Sk,Ik,Qk,Rk]=Modelll(A,betaF,mu,alpha1,alpha2,lambda,rho,epsi,0.003,n,25,0,0,0,0,0,0,0,0);
%R0=betaF*K/(mu+alpha1+lambda+rhoF)
 t = 1:n;
figure(1)
 ax(1) = subplot(4,1,1);
plot(t,S(t),'k',t,Ss(t),'r',t,Sr(t),'b-o')
title('Susceptibles')
ylabel('S(t)')

 ax(2) = subplot(4,1,2);
plot(t,I(t),'k',t,Is(t),'r',t,Ir(t),'b-o')
title('Infected')
ylabel('I(t)')

ax(3) = subplot(4,1,3);
plot(t,Q(t),'k',t,Qs(t),'r')
title('Quarantine')
 ylabel('Q(t)')
 
  ax(4) = subplot(4,1,4);
plot(t,R(t),'k',t,Rs(t),'r',t,Rr(t),'b-o')
 title('Recovered')
 ylabel('R(t)')
 L1=legend('Deterministic Scenario','Stochastic Scenario','Real Data','location','southwest');
set(L1,'fontsize',6,'fontweight','bold')
saveas(gca,'figure1.eps','epsc');
