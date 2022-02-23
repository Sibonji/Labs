function [] = pprint(P,Z,s)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%fprintf(1,'***************************************************************************\n')
fprintf(1,'%s\n',s)
n = length(Z);
nl = 0;
for k=1:n
   if Z(k) ~= 0 
      fprintf(1,'zero %2.0f: ',k); 
      f = imag(Z(k));
      fprintf(1,'%7.5f + j*%7.5f; nu = %7.5f 1/nu=%7.5f \n',real(Z(k)),f,f,1/f); 
      nl = nl+1;
   end   
end
if nl > 0
    fprintf(1,'---------------------------------------------------------------------------\n')
end
n = length(P);
for k=1:n
    pole = P(k); f0=abs(pole);
    ksi2 = -2*real(pole)/f0;
    fprintf(1,'pole %2.0f: ',k); 
    fprintf(1,'%7.5f + j*%7.5f; nu=%7.5f 1/nu=%7.5f Q=%7.3f 1/Q=%7.5f \n',real(pole),imag(pole),f0,1/f0,1/(ksi2),ksi2); 
end
fprintf(1,'***************************************************************************\n')
end

