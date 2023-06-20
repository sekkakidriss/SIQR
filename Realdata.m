function [Sr,Ir,Qr,Rr]=Realdata(n)
  Sr=xlsread('calibrationdraft.xlsx','Sheet3','N2:N62');
  Ir=xlsread('calibrationdraft.xlsx','Sheet3','O2:O62');
  %Qr=xlsread('calibrationdraft.xlsx','Sheet3','N2:N62');
  Qr=zeros(n,1);
  Rr=xlsread('calibrationdraft.xlsx','Sheet3','L2:L62');
end