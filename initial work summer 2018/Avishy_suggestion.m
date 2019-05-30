%% Avishy's suggestion
% preforming regular fft on sin(alpha) * f(x) + i cos(alpha)  (df/dx)
% as it resembles the Hadamarad gate, we will do it for gaussian and
% rectangular pulses

X=5;     % bound of signal in time
dx=0.1;  %sampling interval
x=-X:dx:(X); 
fs=1/dx; %sampling rate
s1=0.3;

sigma = cat(3,s1,s1);
gm = gmdistribution([-2.5; 2.5],sigma);

% uncomment for gaussian slits
pulse= pdf(gm, x');
% uncomment for rectangular slits
% pulse = rectangularPulse(-3.5,-2.5,x)'+rectangularPulse(2.5,3.5,x)'; 




dpulse_dx=diff(pulse)/dx;
dpulse_dx2=zeros(101,1);
dpulse_dx2(2:end)=dpulse_dx;
dpulse_dx2(1)=(dpulse_dx(2)-dpulse_dx(1))/dx;
dpulse_dx=dpulse_dx2;


 a=0:0.01:1; % phi=a*pi/2, phi(4)=2pi
 w=linspace(-fs/2,fs/2,length(x));
for k=1:length(a)
    
    fx=sin(a(k)*pi/2).*pulse+j*cos(a(k)*pi/2).*dpulse_dx;
    
    F_a = fftshift(fft(fx));
    
    figure(1); clf;
    
    subplot(2,2,1)
    plot(x,pulse);
    str = ['Gaussian probability'];
    title(str);
    xlabel('position');
    axis([-X X -0.3 1.1]);
 
    
    freq_axis1 = [-fs/2 fs/2-0.01 -16 16];
    subplot(2,2,2)
    plot(w,real(F_a));
    str = ['Re(FFT) \alpha = ',num2str(a(k)*pi/2)];
    title(str);
    xlabel('frequency');
    axis(freq_axis1);
    
    subplot(2,2,4)
    plot(w,imag(F_a))
    str = ['Im(FFT) \alpha = ',num2str(a(k)*pi/2)];
    title(str);
    xlabel('frequency');
    axis(freq_axis1);
    
    subplot(2,2,3)
    Mag_Fa(:,k) = abs(F_a);
    plot(w,abs(F_a)); 
    
     freq_axis2 = [-fs/2 fs/2-0.01 -4 16];
     axis(freq_axis2);
    
    str = 'absolute value of FFT';
    title(str);
    xlabel('frequency');
    
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
    if k==1
        F(1:10) = getframe(gcf); % begin with a few constatnt frames
    elseif k==length(x)
        F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
    end
    F(k+10)=getframe(gcf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   pause(0.001)
 end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
video = VideoWriter('suggestion1');
video.FrameRate = 12;
open(video)
writeVideo(video,F);
close(video)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




