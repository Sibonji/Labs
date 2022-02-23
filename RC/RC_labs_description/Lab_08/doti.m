function doti(U0,m,F,f0,R,C)
%
% ѕоследовательный диодный детектор: искажени€ вследствие инерционности
% (distortin owing to inertia) при детектировании јћ-сигнала с
% низкочастотным гармоническим колебанием в качестве модулирующего сигнала
% и при условии, что rd=0
% 
% U0 - амплитуда несущей
% m - коэффициент модул€ции
% F - частота модулирующего сигнала
% f0 - частота несущей (f0/F  - целое число)
% R и C - сопротивление резистора и емкость конденсатора детектора
%
% ѕример обращени€: doti(1,0.75,1e3,1.2e4,1e4,5e-8)

twopi=2*pi; tau=R*C; om0=twopi*f0; 
ot=om0*tau; % ot - denominator in power (or degree) of exponent
c=F/f0; % c - coeffifient between F and f0
n_ep=4; % n_ep - number of envelope's periods for picture
n_cr=n_ep/c; % n_cr - number of carrier's period
np_cr=20000; % np_cr - number of points per carrier'c period
tn_fi=n_cr*np_cr; % tn_fi - total number of points on X-axis 'fi'
dfi=twopi/np_cr; fi=0:dfi:tn_fi*dfi;
% fi=twopi*f0*t; % fi - phase of carrier
% phi=c*fi; phi - phase of envelope

plot(fi,U0*(1+m*sin(c*fi)),':'); grid on; hold on;
plot(fi,-U0*(1+m*sin(c*fi)),':'); hold on;
plot(fi,U0*(1+m*sin(c*fi)).*cos(fi),'c');
% u(U0,m,c,fi)=U0*(1+m*sin(c*fi)).*cos(fi); u - value of AM signal


fi_m=zeros(1,n_cr);
for k=1:n_cr
    fee=(k-1)*twopi; fee=[fee-pi/4 fee+pi/4];
    fi_m(k)=fzero(@(x) ...
        om0*U0*(m*c*cos(c*x)*cos(x)-(1+m*sin(c*x))*sin(x)),fee);
% v(U0,m,c,fi)=om0*U0*(m*c*cos(c*fi).*cos(fi)-(1+m*sin(c*fi)).*sin(fi))
% v - derivative u with respect to fi; du/dt=v*(dfi/dt)
end

k=1;
while k<=n_cr
    fi_min=fi_m(k);
    fi1=fzero(@(x) U0*(1+m*sin(c*x))*cos(x)/R-C*abs(om0*...
        U0*((m*c*cos(c*x)*cos(x)-(1+m*sin(c*x))*sin(x)))),...
        [fi_min fi_min+pi/4]);
    U1=U0*(1+m*sin(c*fi1))*cos(fi1);
    
    for l=k:n_cr
        if k < n_cr
            fi_max=fi_m(k+1);
        else
           fi_max=tn_fi*dfi;
        end
        uC=U1*exp(-(fi_max-fi1)/ot); % uC - voltage on capacitor
        U2=U0*(1+m*sin(c*fi_max))*cos(fi_max);
        if uC < U2
            break
        end
        k=k+1;
    end
    
    

    fi2=fzero(@(x) U1*exp(-(x-fi1)/ot)-U0*(1+m*sin(c*x))*cos(x),...
        [fi_max-pi/2 fi_max]);
    % red drawing: ffc1, ffc2  - fi for cos, ffe - fi for exp
    ffc1=fi_min:dfi:fi1; ffe=fi1:dfi:fi2; ffc2=fi2:dfi:fi_max;
    hold on; plot(ffc1,U0*(1+m*sin(c*ffc1)).*cos(ffc1),'r');
    hold on; plot(ffe, U1*exp(-(ffe-fi1)/ot),'r');
    hold on; plot(ffc2,U0*(1+m*sin(c*ffc2)).*cos(ffc2),'r');
    k=k+1;
end

end
