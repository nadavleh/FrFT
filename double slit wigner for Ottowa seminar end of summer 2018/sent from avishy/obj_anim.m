clear all
load K_object_new %K_object1


rgb=[0.5,0,0.5]; %[0.18, 0.66, 0.66];

for k=5:35,

    data=[];
    
x=xmap{k};

n=size(x);
mx=max(max(x));

rng(9,'twister')
%data = rand(10,10,10);

for i=1:n(1),
    for j=1:n(2),
        if (x(i,j) > 1)
        data(i,j,mx-x(i,j)+1)=x(i,j);
        data(i,j,mx+x(i,j)-2)=x(i,j);
        end
    end
end

cla
data = smooth3(data,'gaussian',3);
patch(isocaps(data,.5),...
   'FaceColor','interp','EdgeColor','none');
p1 = patch(isosurface(data,.5),...
   'FaceColor',rgb,'EdgeColor','none');

%[0.8,0.2,0.8];
%[0.5,0,0.5];

%p1 = patch(isosurface(data,.5),...
%   'FaceColor',[230,212,42]/256,'EdgeColor','none');


isonormals(data,p1)
view(3); 
axis vis3d tight
camlight left; 
%colormap jet
%grad=colorGradient(rgb/10, rgb,128); %[1 0.5 0.8]/10, [1 0.5 0.8],128); %[0.1 0.1 0.1]/10, [0.6 0.1 0.8], 128);
%colormap(grad)
lighting gouraud
%brighten(0.5);

axis equal
whitebg(gcf,'black');

f=gcf;
f.Color='black';

xlim([0,85]);
ylim([0,85]);
zlim([0,30]);

view(180/35*k,50/35*k+20); %44);

ax=gca;
ax.Box='off';
% ax.XAxis.Color='k';
% ax.YAxis.Color='k';
% ax.ZAxis.Color='k';
pause(0.1);
end