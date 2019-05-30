% x=-2:0.1:2;
% 
% p=normpdf(x,0,0.5);

figure(1);
hold on

% plot(x,p);

for x=-2:0.005:2,
    plot([x,x],[-0.1,-0.5],'color',[0.6,0,1]*normpdf(x,0,0.5));
end
