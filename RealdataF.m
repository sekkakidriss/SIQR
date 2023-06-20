function [Sr,Ir,Qr,Rr]=RealdataF(n)
  Sr=xlsread('calibrationdraft.xlsx','Sheet3','N2:N92');
  Ir=xlsread('calibrationdraft.xlsx','Sheet3','O2:O92');
  %Qr=xlsread('calibrationdraft.xlsx','Sheet3','N2:N62');
  Qr=zeros(n,1);
  Rr=xlsread('calibrationdraft.xlsx','Sheet3','L2:L92');
end