function ex22_2(N,delta_t,fc1,ac1,fc2, ac2,AMF1,AMF2,m1,m2)
% "����� ���� ����������-�������������� ���������"
% N - ����� ������� �� ��������� ������� (����� �������� �������,
% N ������ ���� ����� �������� 2);
% delta_t - ��������, � ������� ������� ������� �� ��������� �������, [�];
% fc1, fc2 - ������� �������, ���������� ������ ���������� �������������
% �� ��� ������ (��������������, ��� fc2 > fc1);
% ac1, ac2 - ��������� ������� ��������� [�];
% AMF1, AMF2 - ������� ������������ ���������, ���������� ������
% ���������� ������������� �� ��� ������ (��������������, ��� AMF1, AMF2 
% ����� ������ fc1, fc2; ������ ����������� �����������:
% fc1-AMF1 > 0, fc2+AMF2 < N/2-1, fc2-AMF2 >= fc1+AMF1 + 2);
% m1, m2 - ������������ (�������) ���������;
% ������ ���������: ex22_2(2^10,1e-6,20,1,40,1,3,5,0.67,0.67);
% ������ ���������: ex22_2(2^10,1e-6,90,1,110,1,5,3,0.67,0.67);
% T - ������������ ������� [�];
% delta_f - �������� ����� ��������� ����� ��� ������ [��];
% f01, f02 - ������� ������� [��];
% F1, F2 - ������� ������������ ��������� [��]; 
T=N*delta_t;
delta_f=1/T;
f01=fc1*delta_f;
F1=AMF1*delta_f;
f02=fc2*delta_f;
F2=AMF2*delta_f;
% y1, y2 - ��������� �� ���������;
% z1, z2 - ������� 1-�� � 2-�� ��������� � ���������� 1 �;
% u1, u2 - ������������ �� ���������;
% u - ����� ���� �� ���������;
k=0:N-1; tk=delta_t*k;
y1=(1+m1*sin(2*pi*F1*k*delta_t));
z1=ac1*sin(2*pi*f01*k*delta_t);
u1=y1.*z1;
y2=(1+m2*cos(2*pi*F2*k*delta_t));
z2=ac2*sin(2*pi*f02*k*delta_t);
u2=y2.*z2;
u=u1+u2;
% Figure 1 - �������� ������ ��� ������� �������
figure; plot(tk,u); grid on; 
xlabel('t [s]'); ylabel('u [V]'); 
n=0:N-1; fn=delta_f*n;
V=fft(u); % V - �������� FFT ��� ����� ���� ��-���������
% Figure 2 - ������ �������� FFT ��� n �� 0 �� N/2-1
figure; stem(fn(1:N/2),abs(V(1:N/2)),'m.'); grid on;
xlabel('f [Hz]'); ylabel('abs(fft(u)) [V]'); 
% Figure 3 - �������������� ����� �������� FFT ��� n �� 0 �� N/2-1
figure; stem(fn(1:N/2),real(V(1:N/2)),'b.'); grid on; 
xlabel('f [Hz]'); ylabel('real(fft(u) [V])'); 
% Figure 4 - ������ ����� �������� FFT ��� n �� 0 �� N/2-1
figure; stem(fn(1:N/2),imag(V(1:N/2)),'g.'); grid on; 
xlabel('f [Hz]'); ylabel('imag(fft(u) [V])'); 
middle=((fc1+AMF1)+(fc2-AMF2))/2; flrm=floor(middle);
% middle - �������� ����� fc1+AMF1 � fc2-AMF2
w1=[ones(1,flrm) zeros(1,N/2-flrm)]; w1=[w1 fliplr(w1)];
w2=[zeros(1,flrm) ones(1,N/2-flrm)]; w2=[w2 fliplr(w2)];
% w1,w2 - "������������� ����", ���������� ����� �������  
% ����� ���� �� ��������� � ��������� ���� middle*delta_f � ����
% Figure 5 - ����, ���������� ������� ������� �� ��-��������� 
% (������ �������� �������� ��������� � ������������� ��������)
figure; subplot(2,1,1); plot(fn,w1);  
grid on; ylim([-0.5 1.5]); xlabel('f [Hz]'); ylabel('w1'); 
subplot(2,1,2); plot(fn,w2);  
grid on; ylim([-0.5 1.5]); xlabel('f [Hz]'); ylabel('w2');
V1=V.*w1; V2=V.*w2;
% V1, V2 - ���������� ����� ������� V=fft(u);
% Figure 6 - ������� ������� �� ��������� �������
% (������ �������� �������� ��������� � ������������� ��������)
figure; subplot(2,1,1); stem(fn, abs(V1),'m.');
grid on; xlabel('f [Hz]'); ylabel('abs(V1) [V]');
subplot(2,1,2); stem(fn, abs(V2),'m.');
grid on; xlabel('f [Hz]'); ylabel('abs(V2) [V]');
% v1, v2 - ����������������� ��������� ����� ���� �� ���������
v1=ifft(V1); v2=ifft(V2);
% Figure 7 - ��-��������� � �������� ������� fc1 ��� ������� �������
figure; plot(tk,real(v1),'r'); grid on; 
xlabel('t [s]'); ylabel('real(ifft(V.*w1)) [V]'); 
% Figure 8 - ��-��������� � �������� ������� fc2 ��� ������� �������
figure; plot(tk,real(v2),'g'); grid on;
xlabel('t [s]'); ylabel('real(ifft(V.*w2)) [V]');
o=o;









