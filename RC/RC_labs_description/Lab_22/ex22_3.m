function ex22_3(N,delta_t,t0,tp,tau)
% "Одиночный прямоугольный (видео) импульс"
% N - число выборок во временной области (число степеней свободы,
% N должно быть целой степенью 2);
% delta_t - интервал, с которым берутся выборки во временной области, [с];
% t0 - момент начала импульса, выраженный целым числом delta_t;
% tp - длительность импульса, выраженная целым числом delta_t;
% значение t0+tp-1 должно быть меньше или равно N;
% амплитуда импульса равна 1 В;
% tau - постоянная времени интегрирующей (дифференцирующей) цени, [с];
% Пример обращения: ex22_3(2^10,1e-6,201,20,1e-5);
% Пример обращения: ex22_3(2^10,1e-6,201,400,3e-5);
% T - длительность сигнала [с];
% delta_f - интервал между выборками вдоль оси частот [Гц];
T=N*delta_t;
delta_f=1/T;
k=0:N-1; tk=delta_t*k;
u1=zeros(1,t0-1);
u2=ones(1,tp);
u3=zeros(1,N-t0-tp+1);
u=[u1 u2 u3];
% Figure 1 - Исходный сигнал как функция времени на входе интегрирующей
% (дифференцирующей) цепи
figure; plot(tk,u,'b'); ylim([-0.2 1.2]); grid on;
xlabel('t [s]'); ylabel('u [V]');  
n=0:N-1; fn=delta_f*n; max_n=min([fix(T/tau) N/2]);
U=fft(u);
% Figure 2 - Линейчатый спектр исходного сигнала
figure; stem(fn(1:N/2),abs(U(1:N/2)),'m.'); grid on;
xlabel('f [Hz]'); ylabel('abs(U) [V]'); 
% K - комплексный коэффициент передачи интегрирующей цепи;
% int_cir = K(1:N/2) - значения К для положительных частот;
% conj(fliplr(K(2:N/2+1))) - значения К для отрицательных частот;
% int_cir_ - частотная характеристика интегрирующей цепи в целом
K=1./(1+i*2*pi*fn*tau); int_cir=K(1:N/2);
int_cir_=[int_cir conj(fliplr(K(2:N/2+1)))];
% Figure 3 - Амплитудно-частотная характеристика интегрирующей цепи
figure; plot(fn(1:max_n),abs(int_cir(1:max_n))); grid on; 
xlabel('f [Hz]'); ylabel('abs(int_cir)'); 
% Figure 4 - Фазовая характеристика интегрирующей цепи
figure; plot(fn(1:max_n),angle(int_cir(1:max_n))); grid on; 
xlabel('f [Hz]'); ylabel('angle(int_cir) [rad]'); 
V=int_cir_.*U;
v=ifft(V);
% Figure 5 - Действительная часть сигнала на выходе интегрирующей цепи
figure; plot(tk,real(v),'r'); grid on; 
xlabel('t [s]'); ylabel('real(ifft(int cir .*U)) [V]'); 
% Figure 6 - Мнимая часть сигнала на выходе интегрирующей цепи
figure; plot(tk,imag(v),'r'); grid on; 
xlabel('t [s]'); ylabel('imag(ifft(int cir .*U)) [V]');
% K - комплексный коэффициент передачи дифференцирующей цепи;
% dif_cir = K(1:N/2) - значения К для положительных частот;
% conj(fliplr(K(2:N/2+1)) - значения К для отрицательных частот;
% dif_cir_ - частотная характеристика дифференцирующей цепи в целом;
K=1./(1+1./(i*2*pi*fn*tau)); dif_cir=K(1:N/2);
dif_cir_=[dif_cir conj(fliplr(K(2:N/2+1)))];
% Figure 7 - Амплитудно-частотная характеристика дифференцирующей цепи
figure; plot(fn(1:max_n),abs(dif_cir(1:max_n))); grid on; 
xlabel('f [Hz]'); ylabel('abs(dif_cir)'); 
% Figure 8 - Фазовая характеристика дифференцирующей цепи
figure; plot(fn(1:max_n),[pi/2 angle(dif_cir(2:max_n))]); grid on; 
xlabel('f [Hz]'); ylabel('angle(dif_cir) [rad]'); 
W=dif_cir_.*U;
w=ifft(W);
% Figure 9 - Действительная часть сигнала на выходе дифференцирующей цепи
figure; plot(tk,real(w),'r'); grid on; 
xlabel('t [s]'); ylabel('real(ifft(dif cir .*U)) [V]');
% Figure 10 - Мнимая часть сигнала на выходе дифференцирующей цепи
figure; plot(tk,imag(w),'r'); grid on; 
xlabel('t [s]'); ylabel('imag(ifft(dif cir .*U)) [V]');
o=o;