%% plot the wigner distribution rotation and it's radon marginals, this show the FrFT as marginals! 
% plot_wigner is the simpligied version (ugly plots) but is very fast and
% good for trying new ideas on the fly. plot_wigner1 is the slow prety
% version of plot_wigner,  plot_wigner2 is the fast version but with FrFT and not with
% projections,  plot_wigner3 is the slow pretty version of plot_wigner2

X=5;     % bound of signal in time
dx=0.07;  %sampling interval
x=-X:dx:(X); 
fs=1/dx; %sampling rate
thrsh_high=17;
thrsh_middle=10;
thrsh_low=5;
thrsh_very_low=5;
 

gm = gmdistribution([-2.5; 2.5],0.3);
pulse= pdf(gm, x');
% plot(x,pulse);


%[tfr, t, f] = wv(pulse');% This function requires fftshift(real(tfr),2) and
                          % yeilds slightly worse results than those of the
                          % other function
                          
                          
                          
[tfr, t, f] = tfrwv(pulse); % This function requires fftshift(real(tfr),1)
                            % and yeilds better results than wv() which is
                            % written almost the same.

wigner = fftshift(real(tfr),1);

% subplot(2,2,4)
% mesh(wigner)
% subplot(2,2,2)
% plot(sum(wigner,2))
% subplot(2,2,3)
% plot(sum(wigner,1))

a=0:1:360;

for k=1:length(a)
    % Rotate the wignaer matrix by angle alpha
    alpha=a(k);
% because rotation of a square matrix requires interpolation, we introduce
% some nummerical errors and thus we will see the image changes shape
% slightly with each rotation step, 'crop' ensures that the output image is
% cropped to the same size of the original one, and 'bilinear' is the
% interpolation type
    b=imrotate(wigner,alpha,'bilinear','crop'); 
                                                
    clf;
    
    % x and y marginals (these are the radon tranformations!)
    projection1=sum(b,2);
    projection2=sum(b,1);
    
    % plot intensity lines
   idx_high1 = find(projection1>thrsh_high);
   idx_middle1 = find( (projection1<thrsh_high) & (projection1>thrsh_middle) );
   idx_low1 = find( projection1<thrsh_middle & projection1>thrsh_low);
   idx_very_low1 = find( projection1<thrsh_low);



    
    subplot(2,2,4)
    mesh(b)
    zlim([ -4 4])
    view([-1.5 22]);
    
    subplot(2,2,3)
    
    plot(f,projection1)
    ylim([ -10 60])
    camroll(-90)
    hold on;
    if ~isempty(idx_high1)
        stem(f(idx_high1),projection1(idx_high1),'b','MarkerSize',0.01)
    end
    if ~isempty(idx_middle1)
        stem(f(idx_middle1),projection1(idx_middle1),'g','MarkerSize',0.01)
    end
    if ~isempty(idx_low1)
        stem(f(idx_low1),projection1(idx_low1),'y','MarkerSize',0.01)
    end
    if ~isempty(idx_very_low1)
        stem(f(idx_very_low1),projection1(idx_very_low1),'r','MarkerSize',0.01)
    end
    hold off;
    
    subplot(2,2,2)
    plot(x,projection2)
    ylim([ -10 60])

    
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
%     if k==1
%         F(1:10) = getframe(gcf); % begin with a few constatnt frames
%     elseif k==length(x)
%         F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
%     end
%     F(k+10)=getframe(gcf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    


    
    pause(0.01)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
% video = VideoWriter('Wigner_rotation2');
% video.FrameRate = 12;
% open(video)
% writeVideo(video,F);
% close(video)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

