num=[25000 ];
den=[1 55 250 0];
w=logspace(-1,3,100);
figure(1);
bode(num,den,w);
title('BODE PLOT FOR THE GIVEN TRANSFER FUNCTIONG(s)=25000/s(s+5)(s+50)')
grid;
[Gm Pm wcg wcp] =margin(num,den);
Gain_Margin_dB=20*log10(Gm)
Phase_Margin=Pm
Gaincrossover_Frequency=wcg
Phasecrossover_Frequency=wcp