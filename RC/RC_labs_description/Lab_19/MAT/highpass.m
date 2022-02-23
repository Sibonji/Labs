function [] = highpass(P,Z)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if ( nargin == 2 ) 
    zeros=[];
    for k=1:length(Z)
    fp = 1/Z(k);
    if ( imag(fp) < 0 ) fp = conj(fp); end
    zeros = [zeros fp];
    end
end   
poles = [];
for k=1:length(P)
    fp = 1/P(k);
    if ( imag(fp) < 0 ) fp = conj(fp); end
    poles = [poles fp]; 
end
if ( nargin == 2 ) 
    pprint(poles,zeros);
    splane(poles,zeros);
else
pprint(poles);
splane(poles);
end
end

