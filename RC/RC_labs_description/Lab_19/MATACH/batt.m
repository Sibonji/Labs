function [p] = batt(n,eta,eta1)
%returns list of poles
%
p=struct('p',[],'z',[],'nr',0,'nz',0);
p.nr = mod(n,2); 
if ( nargin == 3) 
    eta = (eta1)^(1/n);
    fprintf(1,'stopband = %7.5f \n',eta);
else 
    if ( nargin == 2) 
    x = eta^n;    
    fprintf(1,'stoplevel = %9.5f (%3.1f dB)\n',x,20*log10(x));
    end;
end;
m=floor(n/2)+mod(n,2);
u = pi/(2*n);
i=(0:m-1);
pole = -sin(u*(1+2*i))+j*cos(u*(1+2*i));
if mod(n,2) == 1 
    pole(m)= real(pole(m));
end
p.p=pole;
pprint(pole,p.z,'>> LOWPASS BATTERWOTRH DESIGN');
splane(p);
end



