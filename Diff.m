function [Y]=Diff(S,I,Q,R,Sr,Ir,Qr,Rr,n)
  %X=0;
%   Y=0;
%   %Z=0;W=0;
%   for i=1 : n
%    % X=X+(S(i)-Sr(i))^2;
%     Y=Y+sqrt((S(i)-Sr(i))^2+(I(i)-Ir(i))^2+(R(i)-Rr(i))^2);
%    % Z=Z+(Q(i)-Qr(i))^2;
%    % W=W+(R(i)-Rr(i))^2;
%   end
S0=35435449;
I0=49565;
Q0=0;
r0=1637215;
%Y = sum(sqrt((S(1:n)-Sr(1:n)).^2/S0.^2+ (I(1:n)-Ir(1:n)).^2/I0.^2+(Q(1:n)-Qr(1:n)).^2+(R(1:n)-Rr(1:n)).^2/r0.^2));
Y = sum( (I(1:n)-Ir(1:n)).^2);
end