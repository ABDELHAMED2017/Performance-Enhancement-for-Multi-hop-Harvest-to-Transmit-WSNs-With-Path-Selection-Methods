% This model includes Multiple Eaveasdroppers, 1 Beacons and without PUs
% This figure, we investigate the influences of y_E on OP
tic
clear all;  clc; close all;
PdB           = 10;
IdB           = 5;
LL            = [2 3 4];
PL            = 3;
RR            = 0.5;
% hardware impairment parameter
kappa         = 0.1;
%
xB            = 0.35;
yB            = 0.1;
%
%KK: number of eavesdroppers
KK            = 2;
xE            = 0.5;
yE            = -2:0.1:2;
%
eta           = 0.1;
alpha         = 0.1;
%
Num_Trial     = 10^6;%

% RPS Protocol
h1 = RP_COOP_SIM(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,Num_Trial,kappa);
h2 = RP_THEORY(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa);

% SPS Protocol
h4 = SP_COOP_SIM(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,Num_Trial,kappa);
h5 = SP_THEORY(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa);

% BPS Protocol
h7 = BP_COOP_SIM(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,Num_Trial,kappa);
h8 = BP_THEORY(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa);


legend([h1(1,1) h2(1,1) h4(1,1) h5(1,1) h7(1,1) h8(1,1)],{'RPS - Sim','RPS - Exact', 'SPS - Sim','SPS - Exact', 'BPS - Sim','BPS - Exact'});
xlabel('y_E');
ylabel('Outage probability (OP)');
toc