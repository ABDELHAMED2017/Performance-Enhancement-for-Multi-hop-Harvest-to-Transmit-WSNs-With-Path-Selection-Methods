function SP_ASYM(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa)
% SP_ASYM  : Asymptotic OP for Shorstest Path Protocol
% OP: Outage Probability
OP_ASYMP = zeros(1, length(PdB));
%
for aa = 1 : length(PdB)
    OP_ASYMP(aa) = SPfunc(PdB(aa),IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa);
end
%
OP_ASYMP
%
semilogy(PdB,OP_ASYMP,'b--'); grid on;hold on;
end
%
function out = SPfunc(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa)
% PdB       : Transmit power of beacons
% QdB       : Interference Constraints
% MM        : Number of Paths
% LL        : a vectors including the number of intermediate nodes on each path
% PL        : Path-Loss
% RR        : Target Rate
% xB, yB    : co-ordinates of Beacons
% xP, yP    : co-ordinates of Primary Users
% xE, yE    : co-ordinates of Eavesdopper
% eta       : energy harvesting efficiency
% alpha     : fraction of time for energy harvesting
% Num_Trial : Number of Trials
% From dB to Watt
PP          = 10.^(PdB/10);
II          = 10.^(IdB/10);
% Define kappa
kp          = eta*alpha/(1-alpha);
% Select shortest path, Lmin is the number of hops
Lmin        = min(LL) + 1;
% Define rho
rho         = 2^(Lmin*RR/(1 - alpha)) - 1;
% OP: Outage Probability
OUT         = 1;
%
for bb = 1 : Lmin    
    % Parameter of data links: Lambda_D and Omega_D
    LD     = (1/Lmin)^PL;
    % Parameter of eavesdopping links: Lambda_E and Omega_E
    LE     = sqrt(((bb-1)/Lmin - xE)^2 + yE^2)^PL;
    OME    = LE*rho/(1-kappa*rho);
    hs = 0;        
   for kk = 1 : KK
         gt3    =  nchoosek(KK,kk)*(-1)^(kk+1)*LD*rho/(LD*rho + kk*OME*(1-kappa*rho));
         hs     =  hs + gt3;
   end       
    %     
    OUT    = OUT* (1-hs) ;    
end
%
out = 1 - OUT;
end





