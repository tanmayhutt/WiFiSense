clc;
clear;
num=[25];% Define Numerator
den=[1 6 25];%Define Denominator
sys=tf(num,den)%Transfer Function Generation
disp('The natural frequency is');
wn=sqrt(25)% Calculate Natural frequency
disp('The damping ratio is');
dr=6/(2*wn)% Calculate Damping ratio
disp('The damping frequency is');
wd=wn*sqrt(1-(dr^2))% Calculate Damping Frequency
disp('The Theta value is');
teta=atan(sqrt(1-(dr^2))/dr)%Calculate Theta Value
disp('The Delay time is');
td=((1+0.7*dr)/wn)%Delay Time Calculation
disp('The Rise time is');
tr=((pi-teta)/wd) % Rise time Calculation
disp('The peak time is');
tp=pi/wd %Peak time Calculation
disp('The maximum peak overshoot is');
POS=100*exp((-pi*dr)/(sqrt(1-(dr^2))))% Maximum Overshoot Calculation
disp('The settling time is');
ts=4/(dr*wn)% Settling time at 2%
ts=3/(dr*wn)% Settling time at 5%