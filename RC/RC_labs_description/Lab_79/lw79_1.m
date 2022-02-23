function [v,w,a,lambda,k,z0]=lw79_1(L0,C0,f,l,zl)
% примеры:
% [v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,0.75);
% [v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,-i/(2*pi*2*10^7*10^(-10)));

%L0=0.4*10^(-6);% погонная индуктивность, Гн/м
%C0=7*10^(-11);% погонная емкость, Ф/м
%f=10^6;% частота, Гц
%l=6;% длина линии, м
%zl=37.5;% нагрузка, Ом

u0=1;% амплитуда напряжения на входе, В
v=1/sqrt(L0*C0);% скорость распространения, м/с
w=sqrt(L0/C0);% волновое сопротивление, Ом
a=2*pi*f/v;% фазовая постоянная, рад/м
lambda=v/f;% длина волны, м
k=1/(cos(a*l)+i*w*sin(a*l)/zl);% коэффициент передачи

n=1000;% число точек вдоль линии
% расчет u(x) и i(x) в n точках от 0 до l
x=0:l/n:l;
% au(x) - амплитуда напряжения в точке x, В
% phiu(x) - фаза напряжения в точке x, град
ux=k*u0*(cos(a*(l-x))+i*w*sin(a*(l-x))/zl);
au=abs(ux);
phiu=angle(ux)*180/pi;
%subplot(2,1,1); plot (x, au); grid on;
%xlabel('x, m'); ylabel('abs(u(x))');
%subplot(2,1,2); plot (x, phiu); grid on;
%xlabel('x, m'); ylabel('phi(u(x)), degree');
%figure;
% ai(x) - амплитуда тока в точке x, А
% phii(x) - фаза тока в точке x, град
ix=k*u0*(cos(a*(l-x))/zl+i*sin(a*(l-x))/w);
ai=abs(ix);
phii=angle(ix)*180/pi;
%subplot(2,1,1); plot (x, ai); grid on;
%xlabel('x, m'); ylabel('abs(i(x))');
%subplot(2,1,2); plot (x, phii); grid on;
%xlabel('x, m'); ylabel('phi(i(x)), degree');
% z0 - входное сопротивление, Ом
z0=(1+i*w*tan(a*l)/zl)*zl/(1+i*zl*tan(a*l)/w);
% то же самое: z0=ux(1)/ix(1)

%figure;
subplot(4,1,1); plot (x, au); grid on;
xlabel('x, m'); ylabel('abs(u(x))');
subplot(4,1,2); plot (x, ai); grid on;
xlabel('x, m'); ylabel('abs(i(x))');
subplot(4,1,3); plot (x, phiu); grid on; 
xlabel('x, m'); ylabel('phi(u(x)), degree');
subplot(4,1,4); plot (x, phii); grid on;
xlabel('x, m'); ylabel('phi(i(x)), degree');

figure;

% примеры:
% [v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,0.75);
% figure;[v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,750);
% figure;[v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,-i/(2*pi*2*10^7*10^(-10)));
