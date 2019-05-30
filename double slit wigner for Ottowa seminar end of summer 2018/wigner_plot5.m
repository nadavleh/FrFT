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
 
rgb=[0.5,0,0.5];


gm = gmdistribution([-2.5; 2.5],0.3);
pulse= pdf(gm, x');

[tfr, t, f] = tfrwv(pulse); % This function requires fftshift(real(tfr),1)
                            % and yeilds better results than wv() which is
                            % written almost the same.

wigner = fftshift(real(tfr),1);


% a=0:0.5:4;
a=0:0.1:4;
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


    % main plot
    axes1 = axes('Parent',figure1,...
    'Position',[0.0432010343518681 0.247745974955278 0.46931462326817 0.605921288014311]);
    direction = [0 0 1];
    h=mesh(wigner,'Parent',axes1,'edgecolor',rgb);
    hold(axes1,'on');
    zlim([ -4 4])
    xlim([0 150])
    ylim([0 150])
    view([-1.5 22]);
    rotate(h,direction,alpha)
%%%%%%% avishy add on's%%%%%%
camlight left; 
lighting gouraud
whitebg(gcf,'black');
f=gcf;
f.Color='black';
% view(180/35*k,50/35*k+20);

% % %%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % upper projection
    axes2 = axes('Parent',figure1,...
    'Position',[0.606875355854998 0.631484794275492 0.334659090909091 0.218381037567084]);
    
    box(axes2,'on');
    hold(axes2,'on');
    plot(x,projection1,'Parent',axes2)
    ylim([-1 1.2])
    hold on;
    
for i=1:length(x)
    inten = projection1(i);
    if inten < 10^(-2)
        inten = 0.001;
    elseif  inten > 1
        inten=1;
    end
    plot([x(i),x(i)],[-0.1,-0.5],'color',[1,1,1]*inten);
    
end

% Create xlabel
xlabel('P');

% Create ylabel
ylabel('Intensity of P');

% Create title
title('Marginal of P');
    
    % lower projection
    axes3 = axes('Parent',figure1,...
    'Position',[0.607035490605421 0.275491949910555 0.334509394572029 0.218246869409661]);
    box(axes3,'on');
    
    hold(axes3,'on');
    plot(x,projection2,'Parent',axes3)
    ylim([-1 1.2])
    
for i=1:length(x)
    inten = projection2(i);
    if inten < 10^(-2)
        inten = 0.001;
    elseif  inten > 1
        inten=1;
    end
    plot([x(i),x(i)],[-0.1,-0.5],'color',[1,1,1]*inten);
    
end

% Create xlabel
xlabel('X');

% Create ylabel
ylabel('Intensity of X');

% Create title
title('Marginal of X')
    
%     pause(0.05)
%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
%     if k==1
%         F(1:10) = getframe(gcf); % begin with a few constatnt frames
%     elseif k == length(x)
%         F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
%     end
%     F(k+10)=getframe(gcf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    


%     
%     if k~=length(a) && k~=1
%         close(figure1)
%     end
%      if length(a)==10 || length(a)==20 ||length(a)==30 
%        pause;
%      end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
% video = VideoWriter('Wigner_rotation4');
% video.FrameRate = 20;
% open(video)
% writeVideo(video,F);
% close(video)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

