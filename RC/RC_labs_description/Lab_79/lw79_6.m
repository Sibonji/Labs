function [v,w,a,lambda,k,z0]=lw79_6(L0,C0,R0,l,fmax,zs,zl)
% Линия с потерями потерь (выполнено условие Хевисайда):
% K, z0 и Ke как функции частоты f в пределах от 0 до fmax

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
% lw79_6(0.4e-6,7e-11,5,6,5e7,75,1e10);

n=1000; % n - число точек вдоль оси частот
f=0:fmax/n:fmax;

% U0 - амплитуда напряжения на входе (при х=0), В
% Ux - амплитуда напряжения в точке x, В
% Ul - амплитуда напряжения на нагрузке (при х=l), В
% K - коэффициент передачи
% z0 - входное сопротивление, Ом
% Ke - коэффициент передачи по отношению к ЭДС источника сигнала

% Вычисление gamma, w, z0 и U0 в отсутствие потерь:
gamma=sqrt((0+j*2*pi*f*L0).*(0+j*2*pi*f*C0));
w=sqrt((0+j*2*pi*f*L0)./(0+j*2*pi*f*C0));
% Выделение случаев короткозамкнутой и разомкнутой линии: 
eps=1e-9;
if zl < eps
    K=0;
    z0=w.*tanh(gamma*l);
elseif 1/zl < eps
    K=1./cosh(gamma*l);
    z0=w./tanh(gamma*l);
else
    K=1./(cosh(gamma*l)+w.*sinh(gamma*l)/zl);
    z0=((1+w.*tanh(gamma*l)/zl)./(1+zl*tanh(gamma*l)./w))*zl;
end
U0=z0./(zs+z0);
Ke=K.*z0./(zs+z0);

cnstr=max(abs(K))/10;
K=(abs(K)<cnstr).*K;

figure; plot (f,abs(K),'r'); grid on; hold on;
plot (f,real(K),'c'); hold on; plot (f,imag(K),'b');
xlabel(['f, Hz (zs = ' num2str(zs) ', zl = ' num2str(zl) ...
    '; without losses)']); 
ylabel('abs(K) - r, real(K) - c, imag(K) -b');

cnstr=max(abs(z0))/100;
z0=(abs(z0)<cnstr).*z0;

figure; plot (f,abs(z0),'r'); grid on; hold on;
plot (f,real(z0),'c'); hold on; plot (f,imag(z0),'b');
xlabel(['f, Hz (zs = ' num2str(zs) ', zl = ' num2str(zl) ...
    '; without losses)']); 
ylabel('abs(z0) - r, real(z0) - c, imag(z0) -b, Ohm');

figure; plot (f,abs(Ke),'r'); grid on; hold on;
plot (f,real(Ke),'c'); hold on; plot (f,imag(Ke),'b');
xlabel(['f, Hz (zs = ' num2str(zs) ', zl = ' num2str(zl) ...
    '; without losses)']); 
ylabel('abs(Ke) - r, real(Ke) - c, imag(Ke) -b');

% Вычисление gamma, w, z0, U0 и других параметров в общем случае:
G0=(C0/L0)*R0;
q=R0/L0;
v=1/sqrt(L0*C0);
gamma=sqrt((R0+j*2*pi*f*L0).*(G0+j*2*pi*f*C0));
beta=q/v;
alpha=2*pi*f/v;
lambda=v./f;
w=sqrt((R0+j*2*pi*f*L0)./(G0+j*2*pi*f*C0));
% Выделение случаев короткозамкнутой и разомкнутой линии: 
eps=1e-9;
if zl < eps
    K=0;
    z0=w.*tanh(gamma*l);
elseif 1/zl < eps
    K=1./cosh(gamma*l);
    z0=w./tanh(gamma*l);
else
    K=1./(cosh(gamma*l)+w.*sinh(gamma*l)/zl);
    z0=((1+w.*tanh(gamma*l)/zl)/(1+zl*tanh(gamma*l)./w))*zl;
end
U0=z0./(zs+z0);
Ke=K.*z0./(zs+z0);

figure; plot (f,abs(K),'r'); grid on; hold on;
plot (f,real(K),'c'); hold on; plot (f,imag(K),'b');
xlabel...
    (['f, Hz (zs = ' num2str(zs) ', zl = ' num2str(zl) '; with losses)']); 
ylabel('abs(K) - r, real(K) - c, imag(K) -b');

figure; plot (f,abs(z0),'r'); grid on; hold on;
plot (f,real(z0),'c'); hold on; plot (f,imag(z0),'b');
xlabel...
    (['f, Hz (zs = ' num2str(zs) ', zl = ' num2str(zl) '; with losses)']); 
ylabel('abs(z0) - r, real(z0) - c, imag(z0) -b, Ohm');

figure; plot (f,abs(Ke),'r'); grid on; hold on;
plot (f,real(Ke),'c'); hold on; plot (f,imag(Ke),'b');
xlabel...
    (['f, Hz (zs = ' num2str(zs) ', zl = ' num2str(zl) '; with losses)']);
ylabel('abs(Ke) - r, real(Ke) - c, imag(Ke) -b');

o=o;


