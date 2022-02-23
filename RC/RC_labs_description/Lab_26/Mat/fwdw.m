function [ res ] = fwdw( N,k,m )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
t = 0:1:N;
inp = double (t<=m);
if k < m 
    r = m-k;
    ksi = pi/(2*r);
    for i=0:r
        inp(k+i+1) = cos(ksi*i); 
    end
end
out = 0:1:N;
ksi = 2*pi/(2*N+1);
for n=0:N
    cs = 2*cos(ksi*n*t);
    cs(1) = 1;
    out(n+1) = sum(inp.*cs);
end
res = -N:1:N;
for n=1:N+1
    res(n) = out(N+2-n);
    res(2*N+2-n) = out(N+2-n);
end
res=res./sum(res);
end

