function [res] = qerr (snr,mul)
% perr(snr,mul) returns Q(sqrt(mul)*sqrt(10^snr/10))
if nargin == 1
    m = 1;
else 
    m = sqrt(mul);
end
d = size(snr);
snr = snr/20;
for i=1:d(1) 
    snr(i) = 10^snr(i);
end
res = qfunc(m*snr);
end

