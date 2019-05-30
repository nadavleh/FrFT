%% Avishy's suggestion
% Check if: (cos a) [int  x f(x)^2 dx]  + (sin a) [int x |F(x)|^2 dx]
% =   int x |Fa(x)|^2 dx
% where "int" is an integral with respect to x. So these all are like
% means where the squared magnitudes f(x)^2, |F(x)|^2, and |Fa(x)|^2 are
% (unnormalized) probability densities. Can you verify this numerically
% for a=0 to pi/2.



X=5;     % bound of signal in time
dx=0.1;  %sampling interval
x=-X:dx:(X);
x=x';
fs=1/dx; %sampling rate
s1=0.3;

sigma = cat(3,s1,s1);
gm = gmdistribution([-2.5; 2.5],sigma);

% uncomment for gaussian slits
pulse= pdf(gm, x);
% uncomment for rectangular slits
% pulse = rectangularPulse(-3.5,-2.5,x)'+rectangularPulse(2.5,3.5,x)'; 


 a=0:0.01:1; 
for k=1:length(a)
    
    alpha=a(k)*pi/2;
    
    LHS = cos(alpha)*sum( x.*(pulse.^2) ) - sin(alpha)*sum( x.*(abs(fftshift(fft(pulse))).^2) );
    RHS = sum( x.*( abs(frft(pulse,alpha)).^2 ) );
    
    error(k)=abs( LHS-RHS );   

end

 plot(a*pi/2,error)
 ylabel('Error')
 xlabel('\alpha in [ 0 , \pi/2 ]')
 




