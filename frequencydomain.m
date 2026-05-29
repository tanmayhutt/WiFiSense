clc;
clear;
num = [81];
den = [1 7 81];
sys = tf(num, den)

% 1. Get Bandwidth directly
BW = bandwidth(sys)

% 2. Get Resonant Peak (Linear) and Resonant Frequency (rad/s)
[Mr_linear, wr] = getPeakGain(sys)

% (Optional) Convert the peak to dB if you need it
Mr_dB = 20*log10(Mr_linear)

% 3. Get Stability Margins (Gain Margin, Phase Margin, and their frequencies)
sys_margins = allmargin(sys)

% 4. Plot the Bode plot with stability margins automatically marked
margin(sys)