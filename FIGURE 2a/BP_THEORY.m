function BP_THEORY(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa)
% BP_THEORY  : Theory of Best Path Protocol
% OP: Outage Probability
OP = zeros(1, length(PdB));
%
for aa = 1 : length(PdB)
    OP(aa) = BPfunc(PdB(aa),IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa);
end
%
OP
%
semilogy(PdB,OP,'r-'); grid on;hold on;
end
%
function out = BPfunc(PdB,IdB,LL,KK,PL,RR,xB,yB,xE,yE,eta,alpha,kappa)
% PdB       : Transmit power of beacons
% QdB       : Interference Constraints
% NN        : Number of Beacons
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
% OP: Outage Probability
out         = 1;
%
for aa = 1 : length(LL)
    %
    % the number of hops
    Hop        = LL(aa) + 1;
    % Define rho at each hop
    rho         = 2^(Hop*RR/(1 - alpha)) - 1;
    % Outage at each hop
    OP_hop      = 1;
    for bb = 1 : Hop
        % Parameter of data links: Lambda_D and Omega_D
        LD     = (1/Hop)^PL;
        % Parameter of energy harvesting links: Lambda_B and Omega_B
        LB     = sqrt(((bb-1)/Hop - xB)^2 + yB^2)^PL;
        OMB    = LB/PP/kp;       
        % Parameter of eavesdopping links: Lambda_E and Omega_E
        LE     = sqrt(((bb-1)/Hop - xE)^2 + yE^2)^PL;
        OME    = LE*rho/(1-kappa*rho);
        %
         hs     = 0;    
        gt1    = LD*2*sqrt(OMB*rho/LD/(1-kappa*rho))*besselk(1,2*sqrt(OMB*LD*rho/(1-kappa*rho)));   
        for kk = 1 : KK
            gt3    = nchoosek(KK,kk)*(-1)^kk*LD*2*sqrt(OMB*rho/(1-kappa*rho)/(LD+kk*OME*(1-kappa*rho)/rho))*besselk(1,2*sqrt(OMB/(1-kappa*rho)*(LD*rho + kk*OME*(1-kappa*rho))));
            hs     =  hs + gt3;
        end         
            hs = hs + gt1;   
        %
        OP_hop = OP_hop*hs;
    end
    out = out*(1 - OP_hop);
end
end





