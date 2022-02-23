function [p] = cheb( n,e,eta,eta1)
%returns list of poles
%   Detailed explanation goes here
p=struct('p',[],'z',[],'nr',0,'nz',0);
p.nr = mod(n,2);

if ( nargin==4)
    eta = cos((1/n)*acos(eta1));
    fprintf(1,'stopband = %7.5f \n',eta);
    
else
if ( nargin==3) 
    eta1 = cos(n*acos(eta));
    fprintf(1,'stoplevel = %9.5f (%3.1f dB)\n',eta1,20*log10(eta1));
end
end
m=floor(n/2)+mod(n,2);
u = pi/(2*n);
v=asinh(1/e)/n; shv = sinh(v); chv=cosh(v);
i = (0:m-1);
poles = -shv*sin(u*(1+2*i))+j*chv*cos(u*(1+2*i));  
p.p=poles;
pprint(poles,p.z,'>> LOWPASS CHEBYSHEV DESIGN');
splane(p);
end



