t=0:0.1:5
num1=[400];
den1=[1 20 400];
figure(1)
s1=step(num1,den1,t);
plot(s1,'b');
title('Step response for different Zeta values systems');
xlabel('time(s)');
ylabel('amplitude');
hold on
den2=[1 40 400];
s2=step(num1,den2,t);
plot(s2,'g');
hold on
den3=[1 60 400];
s3=step(num1,den3,t);
plot(s3,'o');
hold on
den4=[1 0 400];
s4=step(num1,den4,t);
plot(s4,'r')