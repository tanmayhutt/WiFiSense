clc;
clear;
num=[25];
den=[1 6 25];
sys=tf(num,den)
R=roots(den)
s=stepinfo(sys,'RiseTimeLimits',[0.00,1.00])
ltiview(sys)