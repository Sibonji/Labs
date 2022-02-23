function [ ] = ach(fmax,poles,zeros )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
narg = nargin;
t = size(poles);
mp = t(2);
if ( narg > 2 )
    t = size(zeros);
    mz=t(2);
end
f=0:0.01:fmax;
t = size(f);
ach = [1:t(2)];
for i= 1:t(2)
   if  narg > 2 
       ach(i) = el_point(f(i),poles,zeros,mp);
   else
       ach(i) = point(f(i),poles,mp);
   end
end
plot (f,ach - max(ach));
end

function [val] = point (f,poles,m) 
tmp = abs(i*f - poles).*abs(-i*f - poles);
if  abs(imag(poles(m))) < 1e-6
    tmp(m) = abs(i*f - poles(m)); 
end
val = 20*log10(1/prod(tmp));
end

function [val] = el_point (f,poles,zeros,m) 
tmp = abs(i*f - poles).*abs(-i*f - poles);
if  abs(imag(poles(m))) < 1e-6
    tmp(m) = abs(i*f - poles(m)); 
end
val = 1/prod(tmp);
tmp = abs(i*f - zeros).*abs(-i*f - zeros);
val = val*prod(tmp);
val = 20*log10(val);
end



