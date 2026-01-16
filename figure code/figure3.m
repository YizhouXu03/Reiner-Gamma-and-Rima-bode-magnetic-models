clear; clf; close all;
figure('Color','w','Position',[100 100 1600 550]);
subplot(1,3,1);
hold on; grid on; view(45,25); axis equal
xlim([0 10]); ylim([0 10]); zlim([-20 10]);
xlabel('Longitude (°)','FontSize',14,'FontWeight','bold');
ylabel('Latitude (°)','FontSize',14,'FontWeight','bold');
zlabel('Altitude (km)','FontSize',14,'FontWeight','bold');
set(gca,'FontSize',12,'LineWidth',1.2)
daspect([1 1 1]);  
M = [1 1 -10; 4 2 -10; 7 1 -10; 3 3 -10]; 
P = [6 6 6];   
for i = 1:size(M,1)
    plot3(M(i,1), M(i,2), M(i,3),'ko','MarkerFaceColor','k','MarkerSize',6);
    text(M(i,1), M(i,2), M(i,3)-1, sprintf('M_{%d}',i),'FontSize',11,'HorizontalAlignment','center');
    plot3([M(i,1) P(1)], [M(i,2) P(2)], [M(i,3) P(3)], 'k--')
end
plot3(P(1), P(2), P(3),'ro','MarkerFaceColor','r','MarkerSize',8);
text(P(1)+0.5, P(2), P(3), 'P','FontSize',12,'Color','r');
title('(a) Equivalent Dipole Model','FontSize',14,'FontWeight','bold');
subplot(1,3,2);
hold on; grid on; view(45,25); axis equal
lon_rg = 295:0.3:310;
lat_rg = 0:0.3:15;
[Lon_rg,Lat_rg] = meshgrid(lon_rg,lat_rg);
alt_rg = -10 * ones(size(Lon_rg));  
scatter3(Lon_rg(:),Lat_rg(:),alt_rg(:),20,'ks','filled')
[Xs,Ys] = meshgrid(295:1:310,0:1:15);
Zs = zeros(size(Xs));
surf(Xs,Ys,Zs,'FaceAlpha',0.1,'EdgeColor','none','FaceColor',[0.5 0.5 0.5]);
xlabel('Longitude (°)','FontSize',14,'FontWeight','bold');
ylabel('Latitude (°)','FontSize',14,'FontWeight','bold');
zlabel('Altitude (km)','FontSize',14,'FontWeight','bold');
title('(b) Reiner Gamma Dipole Distribution (10 km depth)','FontSize',14,'FontWeight','bold');
set(gca,'FontSize',12,'LineWidth',1);
zlim([-20 10]);
daspect([1 1 1]); 
subplot(1,3,3);
hold on; grid on; view(45,25); axis equal
lon_rb = 350:0.3:365;
lat_rb = 5:0.3:20;
[Lon_rb,Lat_rb] = meshgrid(lon_rb,lat_rb);
alt_rb = -10 * ones(size(Lon_rb));  
scatter3(Lon_rb(:),Lat_rb(:),alt_rb(:),20,'kd','filled')
[Xs,Ys] = meshgrid(350:1:365,5:1:20);
Zs = zeros(size(Xs));
surf(Xs,Ys,Zs,'FaceAlpha',0.1,'EdgeColor','none','FaceColor',[0.5 0.5 0.5]);
xlabel('Longitude (°)','FontSize',14,'FontWeight','bold');
ylabel('Latitude (°)','FontSize',14,'FontWeight','bold');
zlabel('Altitude (km)','FontSize',14,'FontWeight','bold');
title('(c) Rima Bode Dipole Distribution (10 km depth)','FontSize',14,'FontWeight','bold');
set(gca,'FontSize',12,'LineWidth',1);
zlim([-20 10]);
daspect([1 1 1]); 
xticks([350 355 360 365]); 
xticklabels({'350°', '355°', '360°', '5°'});  