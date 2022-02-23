function ex22_2(N,delta_t,fc1,ac1,fc2, ac2,AMF1,AMF2,m1,m2)
% "Сумма двух амплитудно-модулированных колебаний"
% N - число выборок во временной области (число степеней свободы,
% N должно быть целой степенью 2);
% delta_t - интервал, с которым берутся выборки во временной области, [с];
% fc1, fc2 - частоты несущих, выраженные числом интервалов дискретизации
% по оси частот (предполагается, что fc2 > fc1);
% ac1, ac2 - амплитуды несущих колебаний [В];
% AMF1, AMF2 - частоты модулирующих колебаний, выраженные числом
% интервалов дискретизации по оси частот (предполагается, что AMF1, AMF2 
% много меньше fc1, fc2; должны выполняться неравенства:
% fc1-AMF1 > 0, fc2+AMF2 < N/2-1, fc2-AMF2 >= fc1+AMF1 + 2);
% m1, m2 - коэффициенты (глубина) модуляции;
% Пример обращения: ex22_2(2^10,1e-6,20,1,40,1,3,5,0.67,0.67);
% Пример обращения: ex22_2(2^10,1e-6,90,1,110,1,5,3,0.67,0.67);
% T - длительность сигнала [с];
% delta_f - интервал между выборками вдоль оси частот [Гц];
% f01, f02 - частоты несущих [Гц];
% F1, F2 - частоты модулирующих колебаний [Гц]; 
T=N*delta_t;
delta_f=1/T;
f01=fc1*delta_f;
F1=AMF1*delta_f;
f02=fc2*delta_f;
F2=AMF2*delta_f;
% y1, y2 - огибающие АМ колебаний;
% z1, z2 - несущие 1-го и 2-го колебаний с амплитудой 1 В;
% u1, u2 - складываемые АМ колебания;
% u - сумма двух АМ колебаний;
k=0:N-1; tk=delta_t*k;
y1=(1+m1*sin(2*pi*F1*k*delta_t));
z1=ac1*sin(2*pi*f01*k*delta_t);
u1=y1.*z1;
y2=(1+m2*cos(2*pi*F2*k*delta_t));
z2=ac2*sin(2*pi*f02*k*delta_t);
u2=y2.*z2;
u=u1+u2;
% Figure 1 - Исходный сигнал как функция времени
figure; plot(tk,u); grid on; 
xlabel('t [s]'); ylabel('u [V]'); 
n=0:N-1; fn=delta_f*n;
V=fft(u); % V - значения FFT для суммы двух АМ-колебаний
% Figure 2 - Модуль значений FFT для n от 0 до N/2-1
figure; stem(fn(1:N/2),abs(V(1:N/2)),'m.'); grid on;
xlabel('f [Hz]'); ylabel('abs(fft(u)) [V]'); 
% Figure 3 - Действительная часть значений FFT для n от 0 до N/2-1
figure; stem(fn(1:N/2),real(V(1:N/2)),'b.'); grid on; 
xlabel('f [Hz]'); ylabel('real(fft(u) [V])'); 
% Figure 4 - Мнимая часть значений FFT для n от 0 до N/2-1
figure; stem(fn(1:N/2),imag(V(1:N/2)),'g.'); grid on; 
xlabel('f [Hz]'); ylabel('imag(fft(u) [V])'); 
middle=((fc1+AMF1)+(fc2-AMF2))/2; flrm=floor(middle);
% middle - середина между fc1+AMF1 и fc2-AMF2
w1=[ones(1,flrm) zeros(1,N/2-flrm)]; w1=[w1 fliplr(w1)];
w2=[zeros(1,flrm) ones(1,N/2-flrm)]; w2=[w2 fliplr(w2)];
% w1,w2 - "прямоугольные окна", вырезающие части спектра  
% суммы двух АМ колебаний с частотами ниже middle*delta_f и выше
% Figure 5 - окна, вырезающие спектры каждого из АМ-колебаний 
% (правые половины графиков относятся к отрицательным частотам)
figure; subplot(2,1,1); plot(fn,w1);  
grid on; ylim([-0.5 1.5]); xlabel('f [Hz]'); ylabel('w1'); 
subplot(2,1,2); plot(fn,w2);  
grid on; ylim([-0.5 1.5]); xlabel('f [Hz]'); ylabel('w2');
V1=V.*w1; V2=V.*w2;
% V1, V2 - вырезанные части спектра V=fft(u);
% Figure 6 - Спектры каждого из колебаний порознь
% (правые половины графиков относятся к отрицательным частотам)
figure; subplot(2,1,1); stem(fn, abs(V1),'m.');
grid on; xlabel('f [Hz]'); ylabel('abs(V1) [V]');
subplot(2,1,2); stem(fn, abs(V2),'m.');
grid on; xlabel('f [Hz]'); ylabel('abs(V2) [V]');
% v1, v2 - восстанавливаемые слагаемые суммы двух АМ колебаний
v1=ifft(V1); v2=ifft(V2);
% Figure 7 - АМ-колебание с частотой несущей fc1 как функция времени
figure; plot(tk,real(v1),'r'); grid on; 
xlabel('t [s]'); ylabel('real(ifft(V.*w1)) [V]'); 
% Figure 8 - АМ-колебание с частотой несущей fc2 как функция времени
figure; plot(tk,real(v2),'g'); grid on;
xlabel('t [s]'); ylabel('real(ifft(V.*w2)) [V]');
o=o;









