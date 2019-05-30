%% distance between waves in a two slit Frft
thrsh=0.95;
 for k=1:length(a)

    
    figure(1); clf;
    freq_axis = [-fs/2 fs/2 -2 2];

    plot(w,abs(Mag_Fa(:,k))); 

    str = 'absoloute value of FrFT';
    title(str);
    xlabel('frequency');
    axis(freq_axis);
    
    
    idx = find(Mag_Fa(:,k)>thrsh);


    % the waves are mirrored around the middle index, so that the distance
    % is the differebce between the end of the first quarter's index and 
    % the 3/4  quarter's index
    idx_diff1 = idx(ceil(0.75*length(idx)))-idx(floor(0.5*length(idx)));
    
    idx_diff2 = idx(ceil(0.75*length(idx)))-idx(floor(0.25*length(idx)));
    
    
    wave_distance1(k)=idx_diff1*dt;
    wave_distance2(k)=idx_diff2*dt;
    
    x1 = 0:0.01:(idx_diff1)*dt;
    y1 = ones(length(x1),1);
    
    
    x2 = -(idx_diff2/2)*dt:0.01:(idx_diff2/2)*dt;
    y2 = 1.1*ones(length(x2),1);
    


    
    hold on;
    plot(x1,y1,'*');   
    plot(x2,y2,'*');
    pause(0.001)  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%for video%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if k==1
        F(1:10) = getframe(gcf); % begin with a few constatnt frames
    elseif k==length(t)
        F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
    end
    F(k+10)=getframe(gcf);
    pause(0.01)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

 end
 clf;
 wave_distance1=wave_distance1/wave_distance1(1); %normalize distance to 1
 wave_distance2=wave_distance2/wave_distance2(1); %normalize distance to 1
 plot(linspace(0,pi/2,length(wave_distance1)),wave_distance1); hold on
 plot(linspace(0,pi/2,length(wave_distance1)),wave_distance2)
 xlabel('\alpha')
 title('Distance between wave packets');
 conjecture=cos(linspace(0,pi/2,length(wave_distance1)));
 hold on;
 plot(linspace(0,pi/2,length(wave_distance1)),conjecture)
 legend('Normalized Distance between distant wave packets','Normalized Distance between adjacent wave packets', 'cos(\alpha)')
 
 %% video
video = VideoWriter('wave_packet_distance_3slits');
video.FrameRate = 50;
open(video)
writeVideo(video,F);
close(video)