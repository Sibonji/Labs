function [] = splane( poles, zeros )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
scatter(0,0,32,'k','filled');
hold on
xlabel('Re(s)'); ylabel('Im(s)'); title('s-plane');
ymax = max(imag(poles));
xmin = min(real(poles));
xmin = min(-1,xmin);
scatter(real(poles),imag(poles),100,'rx');
if ( nargin == 2 )
scatter(real(zeros),imag(zeros),64,'b');
ymax=max(ymax,max(imag(zeros)));
end
hold off
axis([xmin 0.05 -0.1 ymax+0.1]);
grid on;
end

