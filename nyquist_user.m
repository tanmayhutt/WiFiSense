num=[1];
den=[1 10];
figure(1);
nyquist(num,den)
title('NYQUIST PLOT FOR THE TRANSFER FUNCTION G(s)=1/S(S+1)(S+2)')
[Gm,Pm,Wcg,Wcp] =margin(num,den);
Gain_Margin=Gm
Phase_Margin=Pm
PhaseCrossover_Frequency=Wcg
GainCrossover_Frequency=Wcp