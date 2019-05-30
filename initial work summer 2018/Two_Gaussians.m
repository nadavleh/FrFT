%% Gaussian pulse Frft and two slits

X=5;     % bound of signal in time
dx=0.1;  %sampling interval
x=-X:dx:(X); 
fs=1/dx; %sampling rate

 

gm = gmdistribution([-2.5; 2.5],0.3);
pulse= pdf(gm, x');
plot(x,pulse)

 a=0:0.01:1; % phi=a*pi/2, phi(4)=2pi
 w=linspace(-fs/2,fs/2,length(x));
 for k=1:length(a)
    F_a = frft(pulse,a(k));
    
    figure(1); clf;
    
    subplot(2,2,1)
    plot(x,pulse);
    str = 'gaussian pulse';
    title(str);
    xlabel('position');
    axis([-X X -0.3 0.5]);
 
    
    freq_axis = [-fs/2 fs/2-0.01 -1 1];
    subplot(2,2,2)
    plot(w,real(F_a));
    str = ['Re(FrFT) \alpha = ', num2str(a(k)*pi/2)];
    title(str);
    xlabel('frequency');
    axis(freq_axis);
    
    subplot(2,2,4)
    plot(w,imag(F_a))
    str = ['Im(FrFT)'];
    title(str);
    xlabel('frequency');
    axis(freq_axis);
    
    subplot(2,2,3)
    Mag_Fa(:,k) = abs(F_a);
    plot(w,abs(F_a)); 

    str = ['absulute value of FrFT'];
    title(str);
    xlabel('frequency');
    axis(freq_axis);
    
 
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
%     if k==1
%         F(1:10) = getframe(gcf); % begin with a few constatnt frames
%     elseif k==length(x)
%         F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
%     end
%     F(k+10)=getframe(gcf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
  pause(0.001) 
    
 end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
% video = VideoWriter('Gaussian_pulses');
% video.FrameRate = 12;
% open(video)
% writeVideo(video,F);
% close(video)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% polar plot

% figure('color','white');
% subplot(1,2,1)
% polarplot3d(Mag_Fa,'plottype','wire','angularrange',[0 2*pi]);
% view([-18 76]);
% subplot(1,2,2)
% polarplot3d(Mag_Fa,'plottype','surfcn','angularrange',[0 2*pi]);
% view([-18 76]);


