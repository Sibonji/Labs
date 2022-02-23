function [v,w,a,lambda,k,z0]=lw79_5(L0,C0,R0,f,l,zs,zl)
% ����� � �������� ������ (��������� ������� ���������):
% ������� ����� ���������� ��� ����� zs � zl 

% L0 - �������� �������������, ��/�
% C0 - �������� �������, �/�
% R0 - �������� �������������, ��
% G0 - �������� ������������: G0=(C0/L0)*R0, 1/��
% f - �������, ��
% l - ����� �����, �
% zs - ������������� ��������� �������, ��
% zl - ��������, ��

% ��� ��������� ������� �������������� ������ 1 �

% q=R0/L0=G0/C0 - �������� ���������, 1/�
% v - �������� ���������������: v=1/sqrt(L0*C0), �/�
% gamma - ���������� ���������������:
% gamma=sqrt((R0+j*2*pi*f*L0)*(G0+j*2*pi*f*C0)), 1/�
% gamma=beta+j*alph: beta=q/v, alpha=2*pi*f/v=2*pi/lambda  
% beta - ���������� ���������, 1/�
% alpha - ������� ��������� (�������� �����), ���/�
% lambda - ����� �����: lambda=v/f, �
% w - �������� �������������:
% w=sqrt((R0+j*2*pi*f*L0)/(G0+j*2*pi*f*C0)), ��

% ������ ���������:
% lw79_5(0.4*10^(-6),7*10^(-11),5,5*10^7,6,75,1e10);

n=1000; % n - ����� ����� ����� �����
x=0:l/n:l;

% U0 - ��������� ���������� �� ����� (��� �=0), �
% Ux - ��������� ���������� � ����� x, �
% Ul - ��������� ���������� �� �������� (��� �=l), �
% K - ����������� ��������
% z0 - ������� �������������, ��

% ���������� gamma, w, z0 � U0 � ���������� ������:
gamma=sqrt((0+j*2*pi*f*L0)*(0+j*2*pi*f*C0));
w=sqrt((0+j*2*pi*f*L0)/(0+j*2*pi*f*C0));
% ��������� ������� ���������������� � ����������� �����: 
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

% ���������� gamma, w, z0, U0 � ������ ���������� � ����� ������:
G0=(C0/L0)*R0;
q=R0/L0;
v=1/sqrt(L0*C0);
gamma=sqrt((R0+j*2*pi*f*L0)*(G0+j*2*pi*f*C0));
beta=q/v;
alpha=2*pi*f/v;
lambda=v/f;
w=sqrt((R0+j*2*pi*f*L0)/(G0+j*2*pi*f*C0));
% ��������� ������� ���������������� � ����������� �����: 
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


