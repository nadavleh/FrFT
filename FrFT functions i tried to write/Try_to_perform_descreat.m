%% Try to perform descreat FrFT via SVD decomposition of the regular DFT matrix
%  We decomposed the DFT matrix 'A' into an SVD form and took the middle
%  'S'
%  matrix (the Diagonal matrix) to the power of the angle 'a'. this didnt
%  work


n=256;
j=0:(n-1); J=ones(n,1)*j;
k=j; K=k'*ones(1,n);
A=exp(-i*2*pi*J.*K/n); %DFT matrix
[U,S,V] = svd(A); % singular value dicomosition

T=5;     % bound of signal in time
dt=2*T/n;  %sampling interval
t=-T:dt:(T-dt); 
fs=1/dt; %sampling rate
ts=2;    % start of pulse
tf =3;   % end of pulse
 
%  pulse = rectangularPulse(ts,tf,t)'; % one pulse

% symetric pulses (use only when pulses are phased)
pulse = rectangularPulse(-tf,-ts,t)+rectangularPulse(ts,tf,t); 
 

 a=0:0.01:1; % phi=a*pi/2, phi(4)=2pi
 w=linspace(-fs/2,fs/2,length(t));
 %  w=linspace(-length(t)/2,length(t)/2-1,length(t));

 for k=1:length(a)
%     F_a = fftshift(U*(S.^a(k))*(V')*pulse'); % SVD decomposition
%     F_a = fftshift((A^a(k))*pulse); %comlpete nonesense
    
% the following option was presented in: "A Unified Framework for the
% Fractional Fourier Transform: by
% Gianfranco Cariolaro, Member, IEEE, Tomaso Erseghe, Peter Kraniauskas,
% and Nicola Laurenti. in equation (15) page.4.
% It is noted there: "and proves to be very useful in solving several application
% problems related to the DFT. However, we will see
% in Section IV that this cannot be considered as a fractional
% operator in a strict sense." 
% needless to say it doest work..
%     F_a = fftshift( (A.^( a(k)*pi/2) )*pulse' ); %try 1
    F_a = fftshift( (A.^( a(k) ) )*pulse' ); %try 2

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


