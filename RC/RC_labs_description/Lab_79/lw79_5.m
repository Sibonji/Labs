function [v,w,a,lambda,k,z0]=lw79_5(L0,C0,R0,f,l,zs,zl)
% Линия с потерями потерь (выполнено условие Хевисайда):
% стоячие волны напряжения при любых zs и zl 

% L0 - погонная индуктивность, Гн/м
% C0 - погонная емкость, Ф/м
% R0 - погонное сопротивление, Ом
% G0 - погонная проводимость: G0=(C0/L0)*R0, 1/Ом
% f - частота, Гц
% l - длина линии, м
% zs - сопротивление источника сигнала, Ом
% zl - нагрузка, Ом

% ЭДС источника сигнала предполагается равным 1 В

% q=R0/L0=G0/C0 - параметр затухания, 1/с
% v - скорость распространения: v=1/sqrt(L0*C0), м/с
% gamma - постоянная распространения:
% gamma=sqrt((R0+j*2*pi*f*L0)*(G0+j*2*pi*f*C0)), 1/м
% gamma=beta+j*alph: beta=q/v, alpha=2*pi*f/v=2*pi/lambda  
% beta - постоянная затухания, 1/м
% alpha - фазовая постояння (волновое число), рад/м
% lambda - длина волны: lambda=v/f, м
% w - волновое сопротивление:
% w=sqrt((R0+j*2*pi*f*L0)/(G0+j*2*pi*f*C0)), Ом

% Пример обращения:
% lw79_5(0.4*10^(-6),7*10^(-11),5,5*10^7,6,75,1e10);

n=1000; % n - число точек вдоль линии
x=0:l/n:l;

% U0 - амплитуда напряжения на входе (при х=0), В
% Ux - амплитуда напряжения в точке x, В
% Ul - амплитуда напряжения на нагрузке (при х=l), В
% K - коэффициент передачи
% z0 - входное сопротивление, Ом

% Вычисление gamma, w, z0 и U0 в отсутствие потерь:
gamma=sqrt((0+j*2*pi*f*L0)*(0+j*2*pi*f*C0));
w=sqrt((0+j*2*pi*f*L0)/(0+j*2*pi*f*C0));
% Выделение случаев короткозамкнутой и разомкнутой линии: 
eps=1e-9;
if zl < eps
    K=0;
    z0=w*tanh(gamma*l);
elseif 1/zl < eps
    K=1/cosh(gamma*l);
    z0=w/tanh(gamma*l);
else
    K=1/(cosh(gamma*l)+w*sinh(gamma*l)/zl);
    z0=((1+w*tanh(gamma*l)/zl)/(1+zl*tanh(gamma*l)/w))*zl;
end
U0=z0/(zs+z0);

Ux=U0*(cosh(gamma*x)-w*sinh(gamma*x)/z0);
figure; plot (x,abs(Ux)); grid on; hold on;

% Вычисление gamma, w, z0, U0 и других параметров в общем случае:
G0=(C0/L0)*R0;
q=R0/L0;
v=1/sqrt(L0*C0);
gamma=sqrt((R0+j*2*pi*f*L0)*(G0+j*2*pi*f*C0));
beta=q/v;
alpha=2*pi*f/v;
lambda=v/f;
w=sqrt((R0+j*2*pi*f*L0)/(G0+j*2*pi*f*C0));
% Выделение случаев короткозамкнутой и разомкнутой линии: 
eps=1e-9;
if zl < eps
    K=0;
    z0=w*tanh(gamma*l);
elseif 1/zl < eps
    K=1/cosh(gamma*l);
    z0=w/tanh(gamma*l);
else
    K=1/(cosh(gamma*l)+w*sinh(gamma*l)/zl);
    z0=((1+w*tanh(gamma*l)/zl)/(1+zl*tanh(gamma*l)/w))*zl;
end
U0=z0/(zs+z0);

Ux=U0*(cosh(gamma*x)-w*sinh(gamma*x)/z0);
plot(x,abs(Ux),'r'); xlabel('x, m'); 
ylabel('abs(Ux) [V]: b - without losses, r - with losses');
figure; plot(x,real(Ux),'c'); grid on; hold on;
plot(x,imag(Ux),'g'); xlabel('x, m'); 
ylabel('c - real(Ux) [V], g - imag(Ux) [V]');

o=o;


