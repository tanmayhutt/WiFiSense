num = [1 4 3]
den= conv ([1 5], [3 4 7])
g = tf (num,den);
[z,p,k] = tf2zp(num,den)
pzmap(g)
