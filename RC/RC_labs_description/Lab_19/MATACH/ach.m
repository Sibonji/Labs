function [] = ach(R,fmax,fmin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
MAX=10; MIN=0; 
if  nargin >= 2 
    MAX=fmax;
end
if  nargin == 3 
    MIN=fmin;
end
step = (MAX-MIN)/1000;
f=MIN:step:MAX;
ach = [1:length(f)];
for i=  1: length(f)
    ach(i) = point(f(i),R);
end
figure(2);
plot (f,ach - max(ach),'b');
grid ON;
xlabel('Normalized frequency (F/F0)');
ylabel('Gain (dB)');
title('Frquency response');
end


function [val] = point (f,R) 
tmp = abs(i*f - R.p).*abs(-i*f - R.p);
if  R.nr > 0
    m = length(R.p);
    tmp(m) = abs(i*f - R.p(m)); 
end    
val = 1/prod(tmp);
%---------------------------------------
if length(R.z) > 0
   tmp = abs(i*f - R.z).*abs(-i*f - R.z);
   val = val*prod(tmp);
end
if ( R.nz > 0 ) 
    val = val*f^R.nz;
end 
val = 20*log10(val);
end



