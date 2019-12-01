function RP_ASYM(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa)
% RP_ASYM  : Asymptotic OP for Random Path Protocol
% OP: Outage Probability
OP = zeros(1, length(PdB));
%
for aa = 1 : length(PdB)
    OP(aa) = RPfunc(PdB(aa),IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa);
end
%
OP
%
semilogy(PdB,OP,'g--'); grid on;hold on;
end
%
function out = RPfunc(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa)
% PdB       : Transmit power of beacons
% QdB       : Interference Constraints
% NN        : Number of beacons
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
II         = 10.^(IdB/10);
% Define kappa
kp          = eta*alpha/(1-alpha);
% OP: Outage Probability
out         = 0;
%
for aa = 1 : length(LL)
    % Number of Hops
    Hop         = LL(aa) + 1;
    % Define rho
    rho         = 2^(Hop*RR/(1 - alpha)) - 1;
    %
    OP_hop      = 1; 
    for bb = 1 : Hop
        % Parameter of data links: Lambda_D and Omega_D
        LD     = (1/Hop)^PL;       
        % Parameter of eavesdopping links: Lambda_E and Omega_E
        LE     = sqrt(((bb-1)/Hop - xE)^2 + yE^2)^PL;
        OME    = LE*rho/(1-kappa*rho);
        %
        hs = 0;   
            
    for kk = 1 : KK
         gt3    =  nchoosek(KK,kk)*(-1)^(kk+1)*LD*rho/(LD*rho + kk*OME*(1-kappa*rho));
         hs     =  hs + gt3;
   end       
    %     
    OP_hop    = OP_hop*( 1 - hs) ;
    end
    out = out + (1 - OP_hop)/length(LL);
end
%
end





