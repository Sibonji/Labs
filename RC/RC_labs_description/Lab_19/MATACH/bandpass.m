function [p] = bandpass(Q,R)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
p=struct('p',[],'z',[],'nr',0,'nz',0);
p.nz = 2*(length(R.p)-length(R.z)) - R.nr;
for k=1:length(R.p)
    fp = R.p(k)/(2*Q);
    roots=[fp+sqrt(fp^2-1) fp-sqrt(fp^2-1)];
    if ( imag(roots(1)) < 0 ) roots(1) = conj(roots(1)); end
    if ( imag(roots(2)) < 0 ) roots(2) = conj(roots(2)); end
    if ( roots(1) == roots(2) ) 
        p.p = [p.p roots(1)]; 
    else
        p.p = [p.p roots]; 
    end
end

for k=1:length(R.z)
    fp = R.z(k)/(2*Q);
    zero=fp+sqrt(fp^2-1);
    if ( imag(zero) < 0 ) zero = conj(zero); end
    p.z = [p.z zero];
    zero=fp-sqrt(fp^2-1);
    if ( imag(zero) < 0 ) zero = conj(zero); end
    p.z = [p.z zero];
end
    pprint(p.p,p.z,'>> BANDPASS CONVERSION');
    splane(p);
end

