%GENERATION OF STEP SIGNAL
N=20;
x=ones(1,N);
n=0:1:N-1;
subplot(4,2,1);
stem(n,x);
xlabel('n');
ylabel('X(n)');
title('Unit Step Signal');
%GENERATION OF RAMP SIGNAL
N=20;
x=n;
n=0:1:N-1;
subplot(4,2,2);
stem(n,x);
xlabel('n');
ylabel('X(n)');
title('Unit Ramp Signal');
%GENERATION OF UNIT IMPULSE SIGNAL
N=20;
x=[ones(1,1),zeros(1,(N-1))];
n=0:1:N-1;
subplot(4,2,3);
stem(n,x);
xlabel('n');
ylabel('X(n)');
title('Unit Impulse Signal');
%GENERATION OF EXPONENTAIL SIGNAL
N=20;
x=exp(n);
n=0:1:N-1;
subplot(4,2,4);
stem(n,x);
xlabel('n');
ylabel('X(n)');
title('Exponentail Signal');

%GENERATE SINUOIDAL SIGNAL
N=20;
x=sin(0.2*pi*n);
n=0:1:N-1;
subplot(4,2,5);
stem(n,x);
xlabel('n');
ylabel('X(n)');
title('Sinusoidal Signal');
%GENERATE AN COSINE SIGNAL
N=20;
x=cos(0.2*pi*n);
n=0:1:N-1;
subplot(4,2,6);
stem(n,x);
xlabel('n');
ylabel('X(n)');
title('Cosine Signal');
N=-20:20;
ramp_N=(N>=0).*N;
subplot(4,2,7);
stem(N,ramp_N);
xlabel('n');
ylabel('X(n)');
title('Ramp Signal');
N=0:1:20;
parabola=0.5*(N.^2);
subplot(4,2,8);
stem(N,parabola);
xlabel('n');
ylabel('X(n)');
title('Parabolic Signal');