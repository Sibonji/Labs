
function lw79_9(L0,C0,R0,f,l,zs,zl)
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

% ЭДС источника сигнала предполагается равной 1 В

% q=R0/L0=G0/C0 - параметр затухания, 1/с
% v - скорость распространения: v=1/sqrt(L0*C0), м/с
% gamma - постоянная распространения:
% gamma=sqrt((R0+j*2*pi*f*L0)*(G0+j*2*pi*f*C0)), 1/м
% gamma=beta+j*alpha: beta=q/v, alpha=2*pi*f/v=2*pi/lambda  
% beta - постоянная затухания, 1/м
% alpha - фазовая постояння (волновое число), рад/м
% lambda - длина волны: lambda=v/f, м
% w - волновое сопротивление:
% w=sqrt((R0+j*2*pi*f*L0)/(G0+j*2*pi*f*C0)), Ом;
% коль скоро выполняется условие Хевисайда, w=sqrt(L0/C0)

% Пример обращения:
% lw79_9(0.4e-6,7e-11,5,1.7e7,18,0,1e10);

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

eps_=1e-9;
if abs(zl) < eps_
    K=0;
    z0=w*tanh(gamma*l);
elseif abs(1/zl) < eps_
    K=1/cosh(gamma*l);
    z0=w/tanh(gamma*l);
else
    K=1/(cosh(gamma*l)+w*sinh(gamma*l)/zl);
    z0=((1+w*tanh(gamma*l)/zl)/(1+zl*tanh(gamma*l)/w))*zl;
end
U0=z0/(zs+z0);

Uxll=U0*(cosh(gamma*x)-w*sinh(gamma*x)/z0); 
% Uxll - стоячая волна в отсутствие потерь (lossless)

% Вычисление gamma, w, z0, U0 и других параметров с учетом потерь:

G0=(C0/L0)*R0;
q=R0/L0;
v=1/sqrt(L0*C0);
gamma=sqrt((R0+j*2*pi*f*L0)*(G0+j*2*pi*f*C0));
beta=q/v;
alpha=2*pi*f/v;
lambda=v/f;
w=sqrt((R0+j*2*pi*f*L0)/(G0+j*2*pi*f*C0));

% Выделение случаев короткозамкнутой и разомкнутой линии: 

if abs(zl) < eps_
    K=0;
    z0=w*tanh(gamma*l);
elseif abs(1/zl) < eps_
    K=1/cosh(gamma*l);
    z0=w/tanh(gamma*l);
else
    K=1/(cosh(gamma*l)+w*sinh(gamma*l)/zl);
    z0=((1+w*tanh(gamma*l)/zl)/(1+zl*tanh(gamma*l)/w))*zl;
end
U0=z0/(zs+z0);

A=1/2*U0*(1+w/z0)*exp(-gamma*x); % A - падающая волна
B=1/2*U0*(1-w/z0)*exp(gamma*x); % B - отраженная волна

figure; plot(x,abs(A)); grid on; hold on;
plot(x,abs(B),'r'); grid on;
xlabel('x [m], lossy');
ylabel('incident (b) and reflected (r) waves amplitude [V]');

figure; plot (x,abs(Uxll)); grid on; hold on;
Uxwl=U0*(cosh(gamma*x)-w*sinh(gamma*x)/z0); 
% Uxwl - стоячая волна при наличии потерь (with loss(es))
plot (x,abs(Uxwl),'r'); grid on;
xlabel('x [m], b - no loss, r - lossy');
ylabel('standing wave amplitude [V]');

o=o;


