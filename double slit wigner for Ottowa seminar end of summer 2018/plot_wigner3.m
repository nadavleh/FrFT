%% plot the wigner distribution rotation, now instead of marginals and intepolation, FrFT
%  plot_wigner3 is the slow pretty movie version for plot_wigner2.


%  plot_wigner is the simpligied version (ugly plots) but is very fast and
% good for trying new ideas on the fly. plot_wigner1 is the slow prety
% version of plot_wigner,  plot_wigner2 is the fast version but with FrFT and not with
% projections,  plot_wigner3 is the slow pretty version of plot_wigner2

X=5;     % bound of signal in time
dx=0.07;  %sampling interval
x=-X:dx:(X); 
fs=1/dx; %sampling rate
thrsh_high=0.9;
thrsh_middle=0.4;
thrsh_low=0.2;
 

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


a=0:0.01:0.01;
for k=1:length(a)
   
   alpha=a(k)*90;
   figure1 = figure;clf;
   
   projection1=abs( frft(pulse, a(k)) );
   projection2=abs( frft(pulse, a(k)+1) );
    
   % plot intensity lines for upper projection
   idx_high1 = find(projection1>thrsh_high);
   idx_middle1 = find( (projection1<thrsh_high) & (projection1>thrsh_middle) );
   idx_low1 = find( projection1<thrsh_middle & projection1>thrsh_low);
   idx_very_low1 = find( projection1<thrsh_low);
   % plot intensity lines for left projection
   idx_high2 = find(projection2>thrsh_high);
   idx_middle2 = find( (projection2<thrsh_high) & (projection2>thrsh_middle) );
   idx_low2 = find( projection2<thrsh_middle & projection2>thrsh_low);
   idx_very_low2 = find( projection2<thrsh_low);


    
    % Wigner function
    axes1 = axes('Parent',figure1,...
         'Position',[0.30227808186578 0.11 0.602721918134223 0.63937707641196]);
    direction = [0 0 1];
    h=mesh(wigner,'Parent',axes1);
    hold(axes1,'on');
    zlim([ -4 4])
    xlim([0 150])
    ylim([0 150])
%     view([-1.5 22]);
    rotate(h,direction,alpha)
% %%%%%%% avishy add on's%%%%%%
% % axis vis3d tight
% camlight left; 
% lighting gouraud
% whitebg(gcf,'black');
% % f=gcf;
% % f.Color='black';
% view(180/35*k,50/35*k+20);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % left projection
    axes2 = axes('Parent',figure1,...
    'Position',[0.300183841028086 0.828571428571428 0.589868514992856 0.133928571428569]);
    
    box(axes2,'on');
    hold(axes2,'on');
    plot(f,projection1,'Parent',axes2)
    ylim([-1 1.2])
    hold on;
    if ~isempty(idx_high1)
        stem(f(idx_high1),projection1(idx_high1),'r','MarkerSize',0.01)
    end
    if ~isempty(idx_middle1)
        stem(f(idx_middle1),projection1(idx_middle1),'y','MarkerSize',0.01)
    end
    if ~isempty(idx_low1)
        stem(f(idx_low1),projection1(idx_low1),'g','MarkerSize',0.01)
    end
    if ~isempty(idx_very_low1)
        stem(f(idx_very_low1),projection1(idx_very_low1),'b','MarkerSize',0.01)
    end
    xlabel({'p',''});
    ylabel('|\psi(p)|','FontSize',14);
    
%     subplot(2,2,3)
    % upper projection
    axes3 = axes('Parent',figure1,'YDir','reverse',...
        'Position',[0.0943979057591628 0.104642857142857 0.135706211327939 0.675091362126244],...
        'CameraUpVector',[-1 6.12323399573677e-17 0]);
    box(axes3,'on');
    hold(axes3,'on');
    plot(x,projection2,'Parent',axes3)
    ylim([-1 1.2])
    if ~isempty(idx_high2)
        stem(x(idx_high2),projection2(idx_high2),'r','MarkerSize',0.01)
    end
    if ~isempty(idx_middle2)
        stem(x(idx_middle2),projection2(idx_middle2),'y','MarkerSize',0.01)
    end
    if ~isempty(idx_low2)
        stem(x(idx_low2),projection2(idx_low2),'g','MarkerSize',0.01)
    end
    if ~isempty(idx_very_low2)
        stem(x(idx_very_low2),projection2(idx_very_low2),'b','MarkerSize',0.01)
    end
    xlabel('x');
    ylabel('|\psi(x)|','FontSize',14);
    

    pause(0.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
%     if k==1
%         F(1:10) = getframe(gcf); % begin with a few constatnt frames
%     elseif k == length(x)
%         F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
%     end
%     F(k+10)=getframe(gcf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    if k~=length(a)
        close(figure1)
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
% video = VideoWriter('Wigner_rotation3');
% video.FrameRate = 20;
% open(video)
% writeVideo(video,F);
% close(video)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

