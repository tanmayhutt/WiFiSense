m=10;
b=2;
k=5;
num=[1];
den=[m b k];
figure(1);
subplot(2,1,1)
sys=tf(num,den)
step(sys)
title('Step response of Openloop Mechanical Translational System(OL)');
figure(1);
subplot(2,1,2);
scl=feedback(sys,1)
step(scl)
title('Step response of Openloop Mechanical Translational System(CL)')