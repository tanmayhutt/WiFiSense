clc;
clear all;
close all;
t=-10:0.01:10;
L=length(t);
for i=1:L
    % to generate a continuous time impulse function
    if t(i)==0
        x1(i)=1;
    else
        x1(i)=0;
    end;
    % to generate a continuous time unit step signal
    if t(i)>=0
        x2(i)=1;
        % to generate a continuous time ramp signal
        x3(i)=t(i);
    else
        x2(i)=0;
        x3(i)=0;
    end;
end;
% to generate a continuous time exponential signal
a=0.85;
x4=a.^t;
figure;
subplot(2,2,1);
plot(t,x1);
grid on;
xlabel('continuous time t ---->');
ylabel('amplitude---->');
title('Continuous time unit impulse signal');
subplot(2,2,2);
plot(t,x2);
grid on;
xlabel('continuous time t ---->');
ylabel('amplitude---->');
title('Unit step signal')
subplot(2,2,3);
plot(t,x3);
grid on;
xlabel('continuous time t ---->');
ylabel('amplitude---->');
title(' Unit ramp signal');
subplot(2,2,4);
plot(t,x4);
xlabel('continuous time t ---->');
grid on;
ylabel('amplitude---->');
title('continuous time exponential signal');