function [p] = highpass(R)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
p=struct('p',[],'z',[],'nr',0,'nz',0);
p.nr = R.nr;
p.nz = 2*length(R.p) -2*length(R.z) - R.nr;
if  length(R.z) ~= 0
   for k=1:length(R.z)
      fp = 1/R.z(k);
      if ( imag(fp) < 0 ) fp = conj(fp); end
      p.z = [p.z fp];
   end
end

for k=1:length(R.p)
    fp = 1/R.p(k);
    if ( imag(fp) < 0 ) fp = conj(fp); end
    p.p = [p.p fp]; 
end
pprint(p.p,p.z,'>> HIGHPASS CONVERSION');
splane(p);
end

