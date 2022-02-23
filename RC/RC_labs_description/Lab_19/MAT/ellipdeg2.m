function k1 = ellipdeg2(N,k,tol,M)
%ellipdeg2 - solves the degree equation in analog elliptic filter design
%
% Usage: k1 = ellipdeg2(N,k,tol,M);
%        k1 = ellipdeg2(N,k,tol);    (use M=7 expansion terms)
%        k1 = ellipdeg2(N,k)         (uses tol=eps, M=7)
%
%        k = ellipdeg2(1/N, k1, tol)  implements the inverse operation
%
% N = analog filter order
% k = elliptic modulus for transition band
% tol = tolerance, e.g., tol=1e-10, default is tol = eps
% M = number of series expansion terms, default M=7
%
% k1 = elliptic modulus for stopband
%
% Notes: the degree equation N*K(k1)/K(k) = K'(k1)/K'(k) is solved for k1, given N,k
%        or, for k, given N,k1
%
%        It computes the nome q of k, then the nome of k1 from q1 = q^N, and calculates
%        k1 from the approximation k1 = 4*sqrt(q1) * (higher orders in q1)
%
%        The inverse of k1 = ellipdeg(N,k) can be calculated from k = ellipdeg(1/N,k1)
%        alternatively, k' = ellipdeg(N,k1'), where k1'=sqrt(1-k1^2), k' = sqrt(1-k^2)
%        
%        it calls ELLIPK to calculate the nome q of the modulus k

if nargin<=3, M=7; end
if nargin==2, tol=eps; end

[K,Kprime] = ellipk(k,tol);  q = exp(-pi*Kprime/K);

q1 = q^N;

m = 1:M;

k1 = 4 * sqrt(q1) * ((1 + sum(q1.^(m.*(m+1))))/(1 + 2*sum(q1.^(m.*m))))^2;


% [EOF]
