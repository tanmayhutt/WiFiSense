%find the stability of linear systems using root locus
%g(s)=K(S+5)/(s^2+4s+20)
clc;
clear all;
num=[1 5];
den=[1 4 20];
rlocus(num,den)
v=[-10,10,-8,8];
axis(v);
axis('SQUARE')
xlabel('REAL AXIS')
ylabel('IMAGINARY AXIS')
title('ROOT LOCUS OF THE SYSTEM K(S+5)/(S^2+4S+20)')