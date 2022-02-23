function Ry(ry) % (i0)
% ry [Ohm]
% Пример обращения: Ry(500)

step_u=1e-5;
UT=0.026; % [V]
 
% Если i0/2=0.5 mA при UBE=0.6 V, то
c=0.0005/exp(0.6/UT); % c=4.7511e-14 [A]
ube=0:step_u:0.7;
plot(ube, c*exp(ube/UT)); grid on; axis([0 1.0 0 0.025]);
xlabel('ube [V]'); ylabel('ie [A]');

% uy >= 0
max_dube1=UT*log(2); % max_dube1=0.018021826694559 [V] при UT=0.026 [V]
dube1=0:step_u:max_dube1-step_u;
i0=1e-3;
pos_uy=dube1+(i0/2)*ry*(exp(dube1/UT)-1)-UT*log(2-exp(dube1/UT));
% figure; plot(dube1*1000,pos_uy*1000); grid on;
% xlabel('dube1 [mV]'); ylabel('uy [mV]');

% uy <= 0
max_duB=UT*log(2); % max_duB=0.018021826694559 [V] при UT=0.026 [V]
duB=0:step_u:max_duB-step_u; % duB=fliplr(-duB);
neg_duB=fliplr(-duB);
i0=1e-3;
neg_uy=UT*log(2-exp(duB/UT))-(i0/2)*ry*(exp(duB/UT)-1)-duB;
neg_uy=fliplr(neg_uy);
% figure; plot(neg_duB*1000,neg_uy*1000); grid on;
% xlabel('duB [mV]'); ylabel('uy [mV]');

figure; plot([neg_duB*1000 dube1*1000],[neg_uy*1000 pos_uy*1000]); 
grid on; xlabel('[duB dube1] [mV]'); 
ylabel(['uy [mV] at i0 = ' num2str(1000*i0) ' mA '...
        'and ry = ' num2str(ry) ' Ohm']);


for i0=0.0005:0.0005:0.002 % i0 [A]
    pos_uy=dube1+(i0/2)*ry*(exp(dube1/UT)-1)-UT*log(2-exp(dube1/UT));
    pos_dury=(i0/2)*ry*(exp(dube1/UT)-1);
    pos_dube2=-UT*log(2-exp(dube1/UT));
    neg_uy=UT*log(2-exp(duB/UT))-(i0/2)*ry*(exp(duB/UT)-1)-duB;
    neg_uy=fliplr(neg_uy);
    neg_dube1=UT*log(2-exp(duB/UT));
    neg_dube1=fliplr(neg_dube1);
    neg_dury=-(i0/2)*ry*(exp(duB/UT)-1);
    neg_dury=fliplr(neg_dury);
    tot_uy=[neg_uy pos_uy];
    tot_dube1=[neg_dube1 dube1];
    tot_dury=[neg_dury pos_dury];
    tot_dube2=[neg_duB pos_dube2];
    figure; 
    plot(tot_uy*1000,tot_dube1*1000); grid on; hold on;
    plot(tot_uy*1000,tot_dury*1000,'r'); hold on;
    plot(tot_uy*1000,tot_dube2*1000,'g'); hold on;
    xlabel(['uy [mV] at i0 = ' num2str(1000*i0) ' mA '...
        'and ry = ' num2str(ry) ' Ohm']);
    ylabel('dube1 (blue), dury (red), dube2 (green) [mV]');
end

for ry=100:200:900 % ry [Ohm]
figure;
for i0=0.0005:0.0005:0.002 % i0 [A]
    pos_uy=dube1+(i0/2)*ry*(exp(dube1/UT)-1)-UT*log(2-exp(dube1/UT));
    pos_dury=(i0/2)*ry*(exp(dube1/UT)-1);
    pos_dube2=-UT*log(2-exp(dube1/UT));
    neg_uy=UT*log(2-exp(duB/UT))-(i0/2)*ry*(exp(duB/UT)-1)-duB;
    neg_uy=fliplr(neg_uy);
    neg_dube1=UT*log(2-exp(duB/UT));
    neg_dube1=fliplr(neg_dube1);
    neg_dury=-(i0/2)*ry*(exp(duB/UT)-1);
    neg_dury=fliplr(neg_dury);
    tot_uy=[neg_uy pos_uy];
    tot_dube1=[neg_dube1 dube1];
    tot_dury=[neg_dury pos_dury];
    tot_dube2=[neg_duB pos_dube2];
    %    plot(tot_uy*1000,tot_dube1*1000); grid on; hold on
    %    plot(tot_uy*1000,tot_dury*1000,'r'); hold on;
    %    plot(tot_uy*1000,tot_dube2*1000,'g'); hold on;
    %    xlabel(['uy [mV] at i0 = ' num2str(1000*i0) ' mA '...
    %        'and ry = ' num2str(ry) ' Ohm']);
    %    ylabel('dube1 (blue), dury (red), dube2 (green) [mV]');
    plot(tot_uy*1000,i0/2*exp(tot_dube1/UT)*1000); grid on; hold on;
    plot(tot_uy*1000,i0/2*exp(-tot_dube2/UT)*1000,'r'); hold on;
end
xlabel(['uy [mV] at ry = ' num2str(ry) ' Ohm']);
ylabel('die1 (blue), die2 (red) [mA]');
end

figure;