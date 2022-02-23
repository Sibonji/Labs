function [] = bandpass(Q,P,Z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if (nargin == 3) 
zeros = [];
for k=1:length(Z)
    fp = Z(k)/(2*Q);
    zero=fp+sqrt(fp^2-1);
    if ( imag(zero) < 0 ) zero = conj(zero); end
    zeros = [zeros zero];
    zero=fp-sqrt(fp^2-1);
    if ( imag(zero) < 0 ) zero = conj(zero); end
    zeros = [zeros zero];
end
end
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
if ( nargin == 3 )
    pprint(poles,zeros);
    splane(poles,zeros);
else
    pprint(poles);
    splane(poles);
end
end

