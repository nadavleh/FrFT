%% Try to perform descreat FrFT via Chirp modulations
% This seems to be in the right direction


n=256;
j=0:(n-1); J=ones(n,1)*j;
k=j; K=k'*ones(1,n);
A=exp(-i*2*pi*J.*K/n); %DFT matrix

T=5;     % bound of signal in time
dt=2*T/n;  %sampling interval
t=-T:dt:(T-dt); 
fs=1/dt; %sampling rate
ts=2;    % start of pulse
tf =3;   % end of pulse


 
%  pulse = rectangularPulse(ts,tf,t)'; % one pulse

% symetric pulses (use only when pulses are phased)
% pulse = rectangularPulse(-tf,-ts,t)'+rectangularPulse(ts,tf,t)'; 

% Gaussian pulses
s1=0.3;
sigma = cat(3,s1,s1);
gm = gmdistribution([-2.5; 2.5],sigma);
pulse= pdf(gm, t');

 

 a=eps:0.01:1; % phi=a*pi/2, phi(4)=2pi
 Ba=(cot(a*pi/2));
 Ca=(csc(a*pi/2));
 Ka = (abs(Ca).^0.5).*exp( (i*pi/2)*(a-sign( sin(a*pi/2) ) ) );
 
 
 
 
 w=linspace(-fs/2,fs/2,length(t));
 %  w=linspace(-length(t)/2,length(t)/2-1,length(t));

 for k=1:length(a)
      Theta_a = diag( exp(i*pi*Ba(k)*(t.^2)) );
      Sigma_a= diag( exp(i*pi*Ba(k)*(w.^2)) );
      
      F_a = fftshift( (Ca(k)/Ka(k))*Sigma_a*A*Theta_a *pulse);  %try 1
%       F_a = fftshift( (1/Ka(k))*Sigma_a*A*Theta_a *pulse); %try 2



    figure(1); clf;
    
    subplot(2,2,1)
    plot(t,pulse);
    str = 'rect pulse';
    title(str);
    xlabel('time');
    axis([-T T -0.3 1.5]);
 
    
%     freq_axis = [-fs/2 fs/2-0.01 -2 2];
    subplot(2,2,2)
    plot(w,real(F_a));
    str = ['Re(FrFT) \alpha = ', num2str(a(k)*pi/2)];
    title(str);
    xlabel('frequency');
%     axis(freq_axis);
    
    subplot(2,2,4)
    plot(w,imag(F_a))
    str = ['Im(FrFT)'];
    title(str);
    xlabel('frequency');
%     axis(freq_axis);
    
    subplot(2,2,3)
%     Mag_Fa(:,k) = abs(F_a);
    plot(w,abs(F_a)); 

    str = ['absulute value of FrFT'];
    title(str);
    xlabel('frequency');
%     axis(freq_axis);
    
 
    pause(0.01)   
    
    
 end


