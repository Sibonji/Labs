function [ out ] = twdw(k,type)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t = 1:1:2*k+1;
switch type
    case 's' %sine window
        ksi = pi/(2*k+2);
        out = sin(ksi.*t);
    case 'c' %raized cosine window
        ksi = 2*pi/(2*k+2);
        out = 1-cos(ksi.*t);
    case 't' %triangular window
        out = t.*(t<=k) + (2*k+2-t).*(t>k); 
    otherwise %rectangular window
        out = t <= (2*k+1);        
end
out = out/sum(out);
end

