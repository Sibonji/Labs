function [pr] = ellp(n,ep,eta,eta1)
%UNTITLED Summary of this function goes here
%Detailed explanation goes here
pr=struct('p',[],'z',[],'nr',0,'nz',0);
pr.nr = mod(n,2);
if ( nargin == 4 )
    k1=1/eta1;
    k = ellipdeg(n,k1);
    fprintf(1,'stopband = %7.5f \n',1/k); 
else
    k = 1/eta;
    k1 = ellipdeg2(n,k);
    fprintf(1,'stoplevel = %9.5f (%3.1f dB)\n',1/k1,20*log10(1/k1));
end
[K,Kp]=ellipk(k); [K1,K1p]=ellipk(k1);
m=floor(n/2); r = mod(n,2);
zeros = [];
for i=1:m
    u = (2*i-1)/n; zeta = cde(u,k); zeros = [zeros j/(k*zeta)];
end
v0 = -j*asne(j/ep,k1)/n;
poles = []; 
for i=1:m
    u = (2*i-1)/n; p = j*cde(u-j*v0,k); poles = [poles p];
end
if ( r ~= 0 ) 
    p = j*sne(j*v0,k);
    poles = [poles p];
end
pr.p = poles;
pr.z = zeros;
pprint(poles,zeros,'>> LOWPASS ELLIPTICAL DESIGN');
splane(pr);
end



