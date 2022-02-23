function [p] = batt(n,eta,eta1)
%returns list of poles
%
if ( nargin == 3) 
    eta = (eta1)^(1/n);
    fprintf(1,'stopband = %7.5f \n',eta);
else 
    if ( nargin == 2) 
    fprintf(1,'stoplevel = %9.5f \n',eta^n);
    end;
end;
m=floor(n/2)+mod(n,2);
u = pi/(2*n);
i=(0:m-1);
pole = -sin(u*(1+2*i))+j*cos(u*(1+2*i));
p=pole;
pprint(pole);
splane(pole);
end



