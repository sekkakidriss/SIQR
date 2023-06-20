function [Sig1, Sig2, Sig3, Sig4]=Volatility(S,I,Q,R,Sr,Ir,Qr,Rr,n)
  %X1=0;Y1=0;Z1=0;W1=0;
  Sig1=0
  Sig2=0
  Sig3=0
  Sig4=0
  for i=1 : n-1
    X1(i)=log(Sr(i)/Sr(i+1));
    Y1(i)=log(Ir(i)/Ir(i+1));
    Z1(i)=log(Qr(i)/Qr(i+1));
    W1(i)=log(Rr(i)/Rr(i+1));
  end
 meanX=mean(X1);
 meanY=mean(Y1);
 meanZ=mean(Z1);
 meanW=mean(W1);
   for i=1 : n-1
    Sig1=Sig1+(X1(i)-mean(X1))^2;
    Sig2=Sig2+(Y1(i)-mean(Y1))^2;
    Sig3=Sig3+(Z1(i)-mean(Z1))^2;
    Sig4=Sig4+(W1(i)-mean(W1))^2;
  end
  Sig1=sqrt((1/(n-1))*Sig1);
  Sig2=sqrt((1/(n-1))*Sig2);
  Sig3=sqrt((1/(n-1))*Sig3);
  Sig4=sqrt((1/(n-1))*Sig4);
end
