function [res] = berr (snr)
% berr(snr) returns B(10^(snr/10))
d = size(snr);
snr=snr/10;
for i=1:d(1) 
    snr(i) = 0.5*10^snr(i);
end
res = 0.5*exp(-snr);
end

