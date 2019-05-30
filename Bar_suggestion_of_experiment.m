%% Bar's suggestion of the experiment
%% rectangular pulse Frft and two slits

X=5;     % bound of signal in time
dx=0.1;  %sampling interval
x=-X:dx:(X); 
fs=1/dx; %sampling rate
s1=0.3;
s2=0:0.001:s1;
s2(2)=eps;


%  a=0:0.01:1; % phi=a*pi/2, phi(4)=2pi
 w=linspace(-fs/2,fs/2,length(x));
for k=1:length(s2)
    if k==1
    gm = gmdistribution([-2.5],s1) % for the first itteration, only one 
                                   % Gaussian.
    else
        sigma = cat(3,s1,s2(k));
        gm = gmdistribution([-2.5; 2.5],sigma);
    end
    pulse= pdf(gm, x');
    
    F_a = fftshift(fft(pulse));
    
    figure(1); clf;
    
    subplot(2,2,1)
    plot(x,pulse);
    str = ['Gaussians, \sigma_{left} = ', num2str(s1)];
    title(str);
    xlabel('position');
    axis([-X X -0.3 0.5]);
 
    
    freq_axis1 = [-fs/2 fs/2-0.01 -4 4];
    subplot(2,2,2)
    plot(w,real(F_a));
    str = ['Re(FFT) \sigma_{right} = ', num2str(s2(k))];
    title(str);
    xlabel('frequency');
    axis(freq_axis1);
    
    subplot(2,2,4)
    plot(w,imag(F_a))
    str = ['Im(FFT)'];
    title(str);
    xlabel('frequency');
    axis(freq_axis1);
    
    subplot(2,2,3)
    Mag_Fa(:,k) = abs(F_a);
    plot(w,abs(F_a)); 
    if k~=2
     freq_axis2 = [-fs/2 fs/2-0.01 -1 8];
     axis(freq_axis2);
    end
    str = ['absolute value of FFT'];
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
video = VideoWriter('Bar''s Experiment Suggestion2');
video.FrameRate = 12;
open(video)
writeVideo(video,F);
close(video)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




