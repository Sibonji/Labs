function standing_waves(l,f,L0,C0)
% Стоячие волны напряжения в линии без потерь при различных zl
% Пример обращения: standing_waves(6,4.25e7,0.4e-6,7e-11)
v=1/sqrt(L0*C0);
w=sqrt(L0/C0);
a=2*pi*f/v;
x=(0:0.001:1)*l;
figure;
zl=1e9;
u=(cos(a*(l-x))+j*w*sin(a*(l-x))/zl)./(cos(a*l)+j*w*sin(a*l)/zl);
plot(x,abs(u),'c'); hold on;
zl=2*w;
u=(cos(a*(l-x))+j*w*sin(a*(l-x))/zl)./(cos(a*l)+j*w*sin(a*l)/zl);
plot(x,abs(u),'r'); hold on;
zl=w;
u=(cos(a*(l-x))+j*w*sin(a*(l-x))/zl)./(cos(a*l)+j*w*sin(a*l)/zl);
plot(x,abs(u),'m'); hold on;
zl=w/2;
u=(cos(a*(l-x))+j*w*sin(a*(l-x))/zl)./(cos(a*l)+j*w*sin(a*l)/zl);
plot(x,abs(u),'g'); hold on;
zl=1e-9;
u=(cos(a*(l-x))+j*w*sin(a*(l-x))/zl)./(cos(a*l)+j*w*sin(a*l)/zl);
plot(x,abs(u),'b'); grid on;
xlabel('x [m]'); ylabel('standing wave amplitude [V]');
o=o;
