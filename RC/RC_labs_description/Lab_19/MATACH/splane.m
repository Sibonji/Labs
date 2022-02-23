function [] = splane( p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
figure(1);
%hold on
%scatter(0,0,32,'k','filled');
ymax = max(imag(p.p));
if length(p.z) > 0 
    ymax=max(ymax,max(imag(p.z)));
end
xmin = min(real(p.p));
xmin = min(-1,xmin);

scatter(real(p.p),imag(p.p),100,'rx');
hold on
if length(p.z) > 0 
   scatter(real(p.z),imag(p.z),64,'bo');
end
if  p.nz > 0 
    scatter(0,0,64,'bo'); 
    text(-0.05,0,sprintf('%i',p.nz));
end
xlabel('Re(s)');
ylabel('Im(s)'); 
title('s-plane');
axis([xmin -xmin/20 -0.05 ymax+0.1])
grid on;
hold off
end

