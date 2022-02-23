function ex22_3(N,delta_t,t0,tp,tau)
% "��������� ������������� (�����) �������"
% N - ����� ������� �� ��������� ������� (����� �������� �������,
% N ������ ���� ����� �������� 2);
% delta_t - ��������, � ������� ������� ������� �� ��������� �������, [�];
% t0 - ������ ������ ��������, ���������� ����� ������ delta_t;
% tp - ������������ ��������, ���������� ����� ������ delta_t;
% �������� t0+tp-1 ������ ���� ������ ��� ����� N;
% ��������� �������� ����� 1 �;
% tau - ���������� ������� ������������� (����������������) ����, [�];
% ������ ���������: ex22_3(2^10,1e-6,201,20,1e-5);
% ������ ���������: ex22_3(2^10,1e-6,201,400,3e-5);
% T - ������������ ������� [�];
% delta_f - �������� ����� ��������� ����� ��� ������ [��];
T=N*delta_t;
delta_f=1/T;
k=0:N-1; tk=delta_t*k;
u1=zeros(1,t0-1);
u2=ones(1,tp);
u3=zeros(1,N-t0-tp+1);
u=[u1 u2 u3];
% Figure 1 - �������� ������ ��� ������� ������� �� ����� �������������
% (����������������) ����
figure; plot(tk,u,'b'); ylim([-0.2 1.2]); grid on;
xlabel('t [s]'); ylabel('u [V]');  
n=0:N-1; fn=delta_f*n; max_n=min([fix(T/tau) N/2]);
U=fft(u);
% Figure 2 - ���������� ������ ��������� �������
figure; stem(fn(1:N/2),abs(U(1:N/2)),'m.'); grid on;
xlabel('f [Hz]'); ylabel('abs(U) [V]'); 
% K - ����������� ����������� �������� ������������� ����;
% int_cir = K(1:N/2) - �������� � ��� ������������� ������;
% conj(fliplr(K(2:N/2+1))) - �������� � ��� ������������� ������;
% int_cir_ - ��������� �������������� ������������� ���� � �����
K=1./(1+i*2*pi*fn*tau); int_cir=K(1:N/2);
int_cir_=[int_cir conj(fliplr(K(2:N/2+1)))];
% Figure 3 - ����������-��������� �������������� ������������� ����
figure; plot(fn(1:max_n),abs(int_cir(1:max_n))); grid on; 
xlabel('f [Hz]'); ylabel('abs(int_cir)'); 
% Figure 4 - ������� �������������� ������������� ����
figure; plot(fn(1:max_n),angle(int_cir(1:max_n))); grid on; 
xlabel('f [Hz]'); ylabel('angle(int_cir) [rad]'); 
V=int_cir_.*U;
v=ifft(V);
% Figure 5 - �������������� ����� ������� �� ������ ������������� ����
figure; plot(tk,real(v),'r'); grid on; 
xlabel('t [s]'); ylabel('real(ifft(int cir .*U)) [V]'); 
% Figure 6 - ������ ����� ������� �� ������ ������������� ����
figure; plot(tk,imag(v),'r'); grid on; 
xlabel('t [s]'); ylabel('imag(ifft(int cir .*U)) [V]');
% K - ����������� ����������� �������� ���������������� ����;
% dif_cir = K(1:N/2) - �������� � ��� ������������� ������;
% conj(fliplr(K(2:N/2+1)) - �������� � ��� ������������� ������;
% dif_cir_ - ��������� �������������� ���������������� ���� � �����;
K=1./(1+1./(i*2*pi*fn*tau)); dif_cir=K(1:N/2);
dif_cir_=[dif_cir conj(fliplr(K(2:N/2+1)))];
% Figure 7 - ����������-��������� �������������� ���������������� ����
figure; plot(fn(1:max_n),abs(dif_cir(1:max_n))); grid on; 
xlabel('f [Hz]'); ylabel('abs(dif_cir)'); 
% Figure 8 - ������� �������������� ���������������� ����
figure; plot(fn(1:max_n),[pi/2 angle(dif_cir(2:max_n))]); grid on; 
xlabel('f [Hz]'); ylabel('angle(dif_cir) [rad]'); 
W=dif_cir_.*U;
w=ifft(W);
% Figure 9 - �������������� ����� ������� �� ������ ���������������� ����
figure; plot(tk,real(w),'r'); grid on; 
xlabel('t [s]'); ylabel('real(ifft(dif cir .*U)) [V]');
% Figure 10 - ������ ����� ������� �� ������ ���������������� ����
figure; plot(tk,imag(w),'r'); grid on; 
xlabel('t [s]'); ylabel('imag(ifft(dif cir .*U)) [V]');
o=o;