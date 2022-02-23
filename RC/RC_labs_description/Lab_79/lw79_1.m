function [v,w,a,lambda,k,z0]=lw79_1(L0,C0,f,l,zl)
% �������:
% [v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,0.75);
% [v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,-i/(2*pi*2*10^7*10^(-10)));

%L0=0.4*10^(-6);% �������� �������������, ��/�
%C0=7*10^(-11);% �������� �������, �/�
%f=10^6;% �������, ��
%l=6;% ����� �����, �
%zl=37.5;% ��������, ��

u0=1;% ��������� ���������� �� �����, �
v=1/sqrt(L0*C0);% �������� ���������������, �/�
w=sqrt(L0/C0);% �������� �������������, ��
a=2*pi*f/v;% ������� ����������, ���/�
lambda=v/f;% ����� �����, �
k=1/(cos(a*l)+i*w*sin(a*l)/zl);% ����������� ��������

n=1000;% ����� ����� ����� �����
% ������ u(x) � i(x) � n ������ �� 0 �� l
x=0:l/n:l;
% au(x) - ��������� ���������� � ����� x, �
% phiu(x) - ���� ���������� � ����� x, ����
ux=k*u0*(cos(a*(l-x))+i*w*sin(a*(l-x))/zl);
au=abs(ux);
phiu=angle(ux)*180/pi;
%subplot(2,1,1); plot (x, au); grid on;
%xlabel('x, m'); ylabel('abs(u(x))');
%subplot(2,1,2); plot (x, phiu); grid on;
%xlabel('x, m'); ylabel('phi(u(x)), degree');
%figure;
% ai(x) - ��������� ���� � ����� x, �
% phii(x) - ���� ���� � ����� x, ����
ix=k*u0*(cos(a*(l-x))/zl+i*sin(a*(l-x))/w);
ai=abs(ix);
phii=angle(ix)*180/pi;
%subplot(2,1,1); plot (x, ai); grid on;
%xlabel('x, m'); ylabel('abs(i(x))');
%subplot(2,1,2); plot (x, phii); grid on;
%xlabel('x, m'); ylabel('phi(i(x)), degree');
% z0 - ������� �������������, ��
z0=(1+i*w*tan(a*l)/zl)*zl/(1+i*zl*tan(a*l)/w);
% �� �� �����: z0=ux(1)/ix(1)

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

% �������:
% [v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,0.75);
% figure;[v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,750);
% figure;[v,w,a,lambda,k,z0]=lw79_1(0.4*10^(-6),7*10^(-11),2*10^7,6,-i/(2*pi*2*10^7*10^(-10)));
