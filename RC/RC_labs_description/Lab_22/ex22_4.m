function ex22_4(N,delta_t,t0,tp,A,fc,a,dilation)
% "��������� ������������"
% N - ����� ������� �� ��������� ������� (����� �������� �������,
% N ������ ���� ����� �������� 2), N>=2^7;
% delta_t - ��������, � ������� ������� ������� �� ��������� �������, [�];
% t0 - ������ ������ ��������, ���������� ����� ������ delta_t;
% tp - ������������ ��������, ���������� ����� ������ delta_t:
% �������� t0+tp-1 ������ ���� ������ ��� ����� N;
% � - ��������� �������� [�];
% fc - ������� �������, ���������� ������ ���������� �������������
% �� ��� ������;
% a - �������� ����������������� ����������� (t0-a*tp ������ ���� 
% ������ ��� ����� 1, t0+tp-1+a*tp ������ ���� ������ ��� ����� N);
% dilation - ����������� ���������� �� ��� ������� (����� ������� 2 < N);
% ������ ���������: ex22_4(2^10,1e-6,21,20,0.33,256,0.2,16);
% ������ ���������: ex22_4(2^10,1e-6,21,20,0.33,256,0.3,16);
% T - ������������ ������� [�]
% delta_f - �������� ����� ��������� ����� ��� ������ [��]
% fp - ������� ���������� ������������� [��]
T=N*delta_t;
delta_f=1/T;
fp=fc*delta_f;
k=0:N-1; tk=delta_t*k; t_max=N/dilation;
n=0:N-1; fn=delta_f*n;
% carrier - ������� ���������  ��� ���������� �� �������������
carrier=sin(2*pi*fp*tk);
% ������������ ������������� u ��� ����������� �� ������
u1=zeros(1,t0-1);
u2=A*ones(1,tp);
u3=zeros(1,N-t0-tp+1);
u=[u1 u2 u3];
u=u.*carrier;
% Figure 1 - ������������ ��� ������� ������� ��� ����������� �� ������
figure; plot(tk(1:t_max),u(1:t_max),'b'); grid on; 
xlabel('t [s]'); ylabel('u [V]');  
U=fft(u);
% Figure 2 - ����������� ������ ������������� ��� ����������� �� ������
figure; stem(fn(1:N/2),abs(U(1:N/2)),'m.'); grid on;
xlabel('f [Hz]'); ylabel('abs(U) [V]');
% ���������� ��������� ����� ������������ ������������ �����������
af=floor(a*tp); t0_b=t0-af; t0_a=t0+af; te_b=t0+tp-1-af; te_a=te_b+2*af;
% ������������ "����������������� ����" win
win1=zeros(1,t0_b-1);
if af~=0
    dphi=pi/(2*af);
    kw2=t0_b:t0_a-1;
    win2=(1-cos((kw2-t0_b)*dphi))/2;
end
win3=ones(1,te_b-t0_a+1);
if af~=0
    kw4=te_b+1:te_a;
    win4=(1+cos((kw4-te_b)*dphi))/2;
end
win5=zeros(1,N-te_a);
if af~=0
    win=[win1 win2 win3 win4 win5];
else
    win=[win1 win3 win5];
end
% Figure 3 - ��������� ���� win, �������������� ����������� �������������
% �� ������
figure; plot(tk(1:t_max),win(1:t_max),'k'); ylim([-0.2 1.2]); grid on;
xlabel('t [s]'); ylabel('win'); 
% ������������ ����������� ������������� � ������������� ���������,
% � ��������� �������� ��������� ����������� �� ������
u1=zeros(1,t0_b-1);
u2=A*ones(1,tp+2*af);
u3=zeros(1,N-te_a);
u=[u1 u2 u3];
% ��������� ������������� � ������������� ��������� �� "����"
u=u.*win; 
u=u.*carrier;
% Figure 4 - ������������ �� ����������� ������� ��� ������� �������
figure; plot(tk(1:t_max),u(1:t_max),'b'); grid on;
xlabel('t [s]'); ylabel('u [V]'); 
U=fft(u);
% Figure 5 - ����������� ������ ������������ �� ����������� �������
figure; stem(fn(1:N/2),abs(U(1:N/2)),'m.'); grid on;
xlabel('f [Hz]'); ylabel('abs(U) [V]'); 
o=o;