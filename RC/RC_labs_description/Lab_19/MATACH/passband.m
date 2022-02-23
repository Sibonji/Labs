function [poles] = passband(P,Q)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
poles = [];
for k=1:length(P)
    fp = P(k)/(2*Q);
    roots=[fp+sqrt(fp^2-1) fp-sqrt(fp^2-1)];
    if ( imag(roots(1)) < 0 ) roots(1) = conj(roots(1)); end
    if ( imag(roots(2)) < 0 ) roots(2) = conj(roots(2)); end
    if ( roots(1) == roots(2) ) 
        poles = [poles roots(1)]; 
    else
        poles = [poles roots]; 
    end
end
pprint(poles);
splane(poles);
end

