function [ inp ] = ach( N,k,m )
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
end

