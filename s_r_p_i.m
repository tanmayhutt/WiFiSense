%RESPONSE OF FIREST ORDER SYSTEM[OL] SUBJECTED TO STEP INPUT
num1=[1];
den1=[1 1];
t=0:0.1:10
subplot(2,4,1)
step(num1,den1,t);
title( 'FOS[OL] WITH STEP INPUT')
xlabel( 'TIME IN SECONDS')
ylabel( 'STEP INPUT')
grid
%RESPONSE OF FIREST ORDER SYSTEM[OL] SUBJECTED TO RAMP INPUT
r=t
t=0:0.1:10
y=lsim(num1,den1,r,t);
subplot(2,4,2)
plot(t,r, '-',t,y,'*')
title( 'FOS[OL] WITH RAMP INPUT');
xlabel( 'TIME IN SECONDS');
ylabel( 'RAMP INPUT AND SYSTEM OUTPUT');
grid
%RESPONSE OF FIREST ORDER SYSTEM[OL] SUBJECTED TO PARABOLIC INPUT
r=((t.^2)/2)
t=0:0.1:10
y=lsim(num1,den1,r,t);
subplot(2,4,3)
plot(t,r, '-',t,y,'*')
title( 'FOS[OL] WITH PARABOLIC INPUT');
xlabel( 'TIME IN SECONDS');
ylabel( 'PARABOLIC INPUT AND SYSTEM OUTPUT');
grid
%RESPONSE OF FIREST ORDER SYSTEM[OL] SUBJECTED TO IMPULSE INPUT
t=0:0.1:10
subplot(2,4,4)
impulse(num1,den1,t);
title( 'FOS[OL] WITH IMPULSE INPUT');
xlabel( 'TIME IN SECONDS');
ylabel( 'SYSTEM OUTPUT');
grid
%RESPONSE OF FIREST ORDER SYSTEM[CL] SUBJECTED TO STEP INPUT
sys=tf(num1,den1);
sys_c1=feedback(sys,1);
subplot(2,4,5)
step(sys_c1,t);
title( 'FOS[CL] WITH STEP INPUT')
xlabel( 'TIME IN SECONDS')
ylabel( 'STEP INPUT')
grid
%RESPONSE OF FIREST ORDER SYSTEM[CL] SUBJECTED TO RAMP INPUT
r=t
t=0:0.1:10
y=lsim(sys_c1,r,t);
subplot(2,4,6)
plot(t,r, '-',t,y,'*')
title( 'FOS[CL] WITH RAMP INPUT');
xlabel( 'TIME IN SECONDS');
ylabel( 'RAMP INPUT AND SYSTEM OUTPUT');
grid
%RESPONSE OF FIREST ORDER SYSTEM[CL] SUBJECTED TO PARABOLIC INPUT
r=((t.^2)/2)
t=0:0.1:10
y=lsim(sys_c1,r,t);
subplot(2,4,7)
plot(t,r, '-',t,y,'*')
title( 'FOS[CL] WITH PARABOLIC INPUT');
xlabel( 'TIME IN SECONDS');
ylabel( 'PARABOLIC INPUT AND SYSTEM OUTPUT');
grid
%RESPONSE OF FIREST ORDER SYSTEM[CL] SUBJECTED TO IMPULSE INPUT
t=0:0.1:10
subplot(2,4,8)
impulse(sys_c1,t);
title( 'FOS[CL] WITH IMPULSE INPUT');
xlabel( 'TIME IN SECONDS');
ylabel( 'SYSTEM OUTPUT');
grid