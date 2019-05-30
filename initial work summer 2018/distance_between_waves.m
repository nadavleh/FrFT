%% distance between waves in a two slit Frft
thrsh=0.95;
 for k=1:length(a)

    
%     figure(1); clf;
%     freq_axis = [-fs/2 fs/2 -2 2];
% 
%     plot(w,abs(Mag_Fa(:,k))); 
% 
%     str = 'absoloute value of FrFT';
%     title(str);
%     xlabel('frequency');
%     axis(freq_axis);
%     
%     
    idx = find(Mag_Fa(:,k)>thrsh);


    % the waves are mirrored around the middle index, so that the distance
    % is the differebce between the end of the first quarter's index and 
    % the 3/4  quarter's index
    idx_diff = idx(ceil(0.75*length(idx)))-idx(ceil(0.25*length(idx)));
    %     idx_diff = idx(length(idx))-idx(1);
    
    wave_distance(k)=idx_diff*dt;
%     
%     x = -(idx_diff/2)*dt:0.0001:(idx_diff/2)*dt;
%     y = ones(length(x),1);
%     
%     hold on;
%     plot(x,y,'*');   
% %     pause()  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%for video%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if k==1
%         F(1:10) = getframe(gcf); % begin with a few constatnt frames
%     elseif k==length(t)
%         F(k+10:k+30) = getframe(gcf); % end with a few constatnt frames
%     end
%     F(k+10)=getframe(gcf);
%     pause()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

 end
 wave_distance=wave_distance/wave_distance(1); %normalize distance to 1
 plot(linspace(0,pi/2,length(wave_distance)),wave_distance)
 xlabel('\alpha')
 title('Distance between wave packets');
 conjecture=cos(linspace(0,pi/2,length(wave_distance)));
 hold on;
 plot(linspace(0,pi/2,length(wave_distance)),conjecture)
 legend('Distance between wave packets', 'cos(\alpha)')
 
 %% video
% video = VideoWriter('wave_packet_distance');
% video.FrameRate = 50;
% open(video)
% writeVideo(video,F);
% close(video)