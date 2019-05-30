%% plot the wigner distribution

X=5;     % bound of signal in time
dx=0.1;  %sampling interval
x=-X:dx:(X); 
fs=1/dx; %sampling rate

 

gm = gmdistribution([-2.5; 2.5],0.3);
pulse= pdf(gm, x');
% plot(x,pulse);


[tfr, t, f] = wv(pulse'); %wv function is not accurate enough
                          %it has descretisation errors and i later use 
                          %

wigner = fftshift(real(tfr),2);

subplot(2,2,4)
mesh(wigner)
subplot(2,2,2)
plot(sum(wigner,2))
subplot(2,2,3)
plot(sum(wigner,1))
