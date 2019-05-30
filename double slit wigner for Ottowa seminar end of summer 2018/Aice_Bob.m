%% Alice And Bob
clear all;

X=5;     % bound of signal in time
dx=0.07;  %sampling interval
x=-X:dx:(X); 
fs=1/dx; %sampling rate
thrsh_high=0.9;
thrsh_middle=0.4;
thrsh_low=0.2;
 
rgb1=[0.5,0,0.5];

red=[1 0 0];
green=[0 1 0];
rgb2 = red;

gm = gmdistribution([-2.5; 2.5],0.3);
pulse= pdf(gm, x');

[tfr, t, f] = tfrwv(pulse); % This function requires fftshift(real(tfr),1)
                            % and yeilds better results than wv() which is
                            % written almost the same.

wigner = fftshift(real(tfr),1);


a=0:0.01:0.03;
for k=1:length(a)
   %%%%%%%%%%%%%%%%%%%%%%%%
   alpha_deg=a(k)*90;
   alpha_rad=a(k)*pi/2;
   figure1 = figure;
   clf;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ALICE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
   projection1=abs( frft(pulse, a(k)) );
   projection2=abs( frft(pulse, a(k)+1) );
    
 
    % main plot Alice
axes1 = axes('Parent',figure1,...
    'Position',[0.0317427010185348 0.617537641621941 0.234418789934833 0.305140038014311]);
    direction = [0 0 1];
    h=mesh(wigner,'Parent',axes1,'edgecolor',rgb1);
    hold(axes1,'on');
    zlim([ -4 4])
    xlim([0 150])
    ylim([0 150])
    view([-1.5 22]);
    rotate(h,direction,alpha_deg)
%%%%%%% avishy add on's%%%%%%
camlight left; 
lighting gouraud
whitebg(gcf,'black');
f=gcf;
f.Color='black';
% % view(180/35*(0.05*k),50/35*(0.05*k)+20);

% % %%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % upper projection Alice
   axes2 = axes('Parent',figure1,...
    'Position',[0.303229522521664 0.783854166666667 0.188437144145002 0.131510416666667]);
    
    box(axes2,'on');
    hold(axes2,'on');
    plot(x,projection1,'Parent',axes2,'color',green)
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
xlabel('X_{A}');


% Create title
title('Intensity');
    
    % lower projection Alice
    axes3 = axes('Parent',figure1,...
    'Position',[0.298631535803161 0.581456953642385 0.192514297530172 0.132356368989083]);
    box(axes3,'on');
    
    hold(axes3,'on');
    plot(x,projection2,'Parent',axes3,'color',green)
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
xlabel('P_{A}');

   
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%BOB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
   projection1_BOB=abs( frft(pulse, a(1)) );
   projection2_BOB=abs( frft(pulse, a(1)+1) ); 

    
 
    % main plot BOB
    axes4 = axes('Parent',figure1,...
    'Position',[0.03125 0.171093749999989 0.234374999999999 0.304166666666664]);
    h=mesh(wigner,'Parent',axes4,'edgecolor',rgb2);
    hold(axes4,'on');
    zlim([ -4 4])
    xlim([0 150])
    ylim([0 150])
    view([-1.5 22]);
    camlight left; 
    lighting gouraud
   
    % upper projection BOB
    axes5 = axes('Parent',figure1,...
    'Position',[0.302083333333333 0.343749999999999 0.18944209039548 0.131510416666664]);
    
    box(axes5,'on');
    hold(axes5,'on');
    plot(x,projection1_BOB,'Parent',axes5)
    ylim([-1 1.2])
    hold on;
    
for i=1:length(x)
    inten = projection1_BOB(i);
    if inten < 10^(-2)
        inten = 0.001;
    elseif  inten > 1
        inten=1;
    end
    plot([x(i),x(i)],[-0.1,-0.5],'color',[1,1,1]*inten);
    
end

% Create xlabel
xlabel('X_{B}');


    
    % lower projection BOB
    axes6 = axes('Parent',figure1,...
    'Position',[0.302604166666667 0.139322916666666 0.189980579096045 0.131979166666665]);
    box(axes6,'on');
    
    hold(axes6,'on');
    plot(x,projection2_BOB,'Parent',axes6)
    ylim([-1 1.2])
    
for i=1:length(x)
    inten = projection2_BOB(i);
    if inten < 10^(-2)
        inten = 0.001;
    elseif  inten > 1
        inten=1;
    end
    plot([x(i),x(i)],[-0.1,-0.5],'color',[1,1,1]*inten);
    
end

% Create xlabel
xlabel('P_{B}');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Bell(k) = 2*(cos(alpha_rad)+sin(alpha_rad));   

    axes7 = axes('Parent',figure1,...
    'Position',[0.531461864406779 0.151629759933772 0.404978813559322 0.314583333333335]);
    box(axes7,'on');
    
    hold(axes7,'on');
    plot((0:0.01:a(k))*0.5*pi,Bell,'Parent',axes7)
    ylim([-2*sqrt(2) 2*sqrt(2) ])
    xlim([0 2*pi ])
    title('Bell-CHSH Coorrelation');
    xlabel('\alpha');

%%%%%%%%%%%%%%%%%%%%%Coordinate-systems%%%%%%%%%%%%%%%


    axes8 = axes('Parent',figure1,...
    'Position',[0.479961158192088 0.589403973509934 0.499999999999998 0.303533733443708]);
     box(axes8,'on');
     hold(axes8,'on');
    % Alice
    plot([0 0], [0 1],'r'); % y axis
    plot([0 1], [0 0],'r'); % x axis  
    % Bob
    plot([0 -sin(alpha_deg*pi/180)], [0 cos(alpha_deg*pi/180)],'g'); % y axis
    plot([0 cos(alpha_deg*pi/180)], [0 sin(alpha_deg*pi/180)],'g'); % x axis 
    
    ylim([-1 1 ])
    xlim([-1 1 ])
    axis square
    title_str = ['\alpha = ', num2str(alpha_deg*pi/180),' [rad]'];
    title(title_str);
    










% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);

 pause(0.05)    
%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
%     if k==1
%         F(1:10) = getframe(gcf); % begin with a few constatnt frames
%     elseif k == length(x)
%         F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
%     end
%     F(k+10)=getframe(gcf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    if k~=length(a) && k~=1
        close(figure1)
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%  for video purpuses  %%%%%%%%%%%%%%%%%%%%%%%%%%
% video = VideoWriter('correlations');
% video.FrameRate = 20;
% open(video)
% writeVideo(video,F);
% close(video)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

