function [v,w,a,lambda,k,z0]=lw79_6(L0,C0,R0,l,fmax,zs,zl)
% ����� � �������� ������ (��������� ������� ���������):
% K, z0 � Ke ��� ������� ������� f � �������� �� 0 �� fmax

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
% lw79_6(0.4e-6,7e-11,5,6,5e7,75,1e10);

n=1000; % n - ����� ����� ����� ��� ������
f=0:fmax/n:fmax;

% U0 - ��������� ���������� �� ����� (��� �=0), �
% Ux - ��������� ���������� � ����� x, �
% Ul - ��������� ���������� �� �������� (��� �=l), �
% K - ����������� ��������
% z0 - ������� �������������, ��
% Ke - ����������� �������� �� ��������� � ��� ��������� �������

% ���������� gamma, w, z0 � U0 � ���������� ������:
gamma=sqrt((0+j*2*pi*f*L0).*(0+j*2*pi*f*C0));
w=sqrt((0+j*2*pi*f*L0)./(0+j*2*pi*f*C0));
% ��������� ������� ���������������� � ����������� �����: 
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

% ���������� gamma, w, z0, U0 � ������ ���������� � ����� ������:
G0=(C0/L0)*R0;
q=R0/L0;
v=1/sqrt(L0*C0);
gamma=sqrt((R0+j*2*pi*f*L0).*(G0+j*2*pi*f*C0));
beta=q/v;
alpha=2*pi*f/v;
lambda=v./f;
w=sqrt((R0+j*2*pi*f*L0)./(G0+j*2*pi*f*C0));
% ��������� ������� ���������������� � ����������� �����: 
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


