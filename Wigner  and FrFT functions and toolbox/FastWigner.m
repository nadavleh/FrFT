function [W]=FastWigner(X,N,a,a_type,cir)
% [W]=FastWigner(X,N,a,a_type,cir) calculates the 1D PWD of image X
% W(i,j,:) is the PWD of pixel X(i,j)
% Inputs:
% X: input image 
% N: operational window size (MUST BE AN EVEN NUMBER)
% a: direction (radians, degrees or slope)
% a_type: according to input a: 'radian', 'degree' or 'slope'
% cir: circularity - optional argument to fit the window to a circular
% pattern. Put here any input  value (e.g.: 1) to accept circularity
% instead of a square window, or nothing to use a square window 
% Outputs:
% W: Pseudo-Wigner Distribution of image X

% By Salvador Gabarda
% Last updated: 14OCT2015
% salvador.gabarda@gmail.com

X=double(X);
X=X+eps; % avoid zeros
if nargin==4
    v=Direction(N,a,a_type);
elseif nargin==5 % when cir is inserted in the input string to use a
    % circular window (As values are calculated by interpolation, some
    % smoothing effect will be present in the function)
    v=Direction(N,a,a_type,cir);
end

for k=1:N
    iz=v(:,:,k);
    de=rot90(rot90(v(:,:,k)));
    AI(:,:,k)=conv2(X,iz,'same');
    AD(:,:,k)=conv2(conj(X),de,'same');
    A(:,:,k)=AD(:,:,k).*AI(:,:,k);
        % activate this step to preserve periodicity
        % this step is required when the function is not real
        %if k==1
            %A(:,:,k)=AI(:,:,k).*conj(AI(:,:,k));
        %end
        
end

Y=fft(A,[],3);
W=fftshift(Y,3);
W=real(W);
