%% three slits

T=5;     % bound of signal in time
dt=0.1;  %sampling interval
t=-T:dt:(T); 
fs=1/dt; %sampling rate


% symetric pulses (use only when pulses are phased)
pulse = rectangularPulse(-4,-3,t)+rectangularPulse(3,4,t) ...
    +rectangularPulse(-0.5,0.5,t);
 

 a=0:0.01:1; % phi=a*pi/2, phi(4)=2pi
 w=linspace(-fs/2,fs/2,length(t));
 for k=1:length(a)
    F_a = frft(pulse,a(k));
    
    figure(1); clf;
    
    subplot(2,2,1)
    plot(t,pulse);
    str = 'rect pulse';
    title(str);
    xlabel('time');
    axis([-T T -0.3 1.5]);
 
    
    freq_axis = [-fs/2 fs/2 -2 2];
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
    
 
    pause(0.0084)   
    
    
 end
%% polar plot

figure('color','white');
subplot(1,2,1)
polarplot3d(Mag_Fa,'plottype','wire','angularrange',[0 2*pi]);
view([-18 76]);
subplot(1,2,2)
polarplot3d(Mag_Fa,'plottype','surfcn','angularrange',[0 2*pi]);
view([-18 76]);

%% regular plot
clf
subplot(1,2,1)
mesh(a,w,Mag_Fa)
hold on
scatter3(a,3.5*cos(linspace(0,pi/2,length(a))),1.5*ones(length(a),1),'.r')
scatter3(a,-3.5*cos(linspace(0,pi/2,length(a))),1.5*ones(length(a),1),'.r')
subplot(1,2,2)
mesh(a,w,Mag_Fa)
hold on
scatter3(a,3.5*cos(linspace(0,pi/2,length(a))),1.5*ones(length(a),1),'.r')
scatter3(a,-3.5*cos(linspace(0,pi/2,length(a))),1.5*ones(length(a),1),'.r')

%% video
 for k=1:length(a)
     
     
    F_a = frft(pulse,a(k));
    
    figure(1); clf;
    
    
    subplot(2,2,1)
    plot(t,pulse);
    str = 'Three slits';
    title(str);
    xlabel('time');
    axis([-T T -0.3 1.5]);
 
    
    freq_axis = [-fs/2 fs/2-1 -2 2];
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
    plot(w,abs(F_a)); 

    str = ['absolute value of FrFT'];
    title(str);
    xlabel('frequency');
    axis(freq_axis);
    
%     draw now;  
    

    if k==1
        F(1:10) = getframe(gcf); % begin with a few constatnt frames
    elseif k==length(t)
        F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
    end
    F(k+10)=getframe(gcf);
    pause(0.084)
 end
video = VideoWriter('three_pulses');
video.FrameRate = 12;
open(video)
writeVideo(video,F);
close(video)
