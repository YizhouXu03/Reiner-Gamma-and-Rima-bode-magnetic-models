clear; close all; clc;
set(0,'defaultfigurecolor','w')
load lptani50rgde.mat        
lpori=lptani50rgde;
load kani50rgde.mat        
kaall=kani50rgde;
load lptani50rbde.mat      
lpallrb=lptani50rbde;
load kani50rbde.mat      
kaallrb=kani50rbde;
in=readtable('reiner_gamma_terrain_data.txt');
lont=table2array(in(:,1));
lont=-lont+360;  
latt=table2array(in(:,2));
ht=table2array(in(:,3));
in2=readtable('rima_bode_terrain_data.txt');
lont2=table2array(in2(:,1));
lont2(lont2<300)=lont2(lont2<300)+360;  
latt2=table2array(in2(:,2));
ht2=table2array(in2(:,3));
lon_lp_re = lpori(:,1); lat_lp_re = lpori(:,2); h_lp_re = lpori(:,3);
bx_lp_re = lpori(:,4); by_lp_re = lpori(:,5); bz_lp_re = lpori(:,6);
bt_lp_re = sqrt(bx_lp_re.^2 + by_lp_re.^2 + bz_lp_re.^2);
lon_ka_re = kaall(:,1); lat_ka_re = kaall(:,2); h_ka_re = kaall(:,3);
bx_ka_re = kaall(:,4); by_ka_re = kaall(:,5); bz_ka_re = kaall(:,6);
bt_ka_re = sqrt(bx_ka_re.^2 + by_ka_re.^2 + bz_ka_re.^2);
lon_lp_rb = lpallrb(:,1); lat_lp_rb = lpallrb(:,2); h_lp_rb = lpallrb(:,3);
bx_lp_rb = lpallrb(:,4); by_lp_rb = lpallrb(:,5); bz_lp_rb = lpallrb(:,6);
bt_lp_rb = sqrt(bx_lp_rb.^2 + by_lp_rb.^2 + bz_lp_rb.^2);
lon_ka_rb = kaallrb(:,1); lat_ka_rb = kaallrb(:,2); h_ka_rb = kaallrb(:,3);
bx_ka_rb = kaallrb(:,4); by_ka_rb = kaallrb(:,5); bz_ka_rb = kaallrb(:,6);
bt_ka_rb = sqrt(bx_ka_rb.^2 + by_ka_rb.^2 + bz_ka_rb.^2);
lon_grid = 295:0.1:310;  
lat_grid = 0:0.1:15;     
[LON, LAT] = meshgrid(lon_grid, lat_grid);
HT = griddata(lont, latt, ht, LON, LAT, 'natural');
contour_levels = min(ht):0.5:max(ht);  
lon_grid_rb = 350:0.1:365;  
lat_grid_rb = 5:0.1:20;     
[LON_RB, LAT_RB] = meshgrid(lon_grid_rb, lat_grid_rb);
HT_RB = griddata(lont2, latt2, ht2, LON_RB, LAT_RB, 'natural');
contour_levels_rb = min(ht2):0.5:max(ht2);  
fig = figure('Units','pixels','Position',[100 100 1500 900]);
mapcmap = jet(256);
colormap(mapcmap)
hmin_re = min([h_lp_re(:); h_ka_re(:)]);
hmax_re = max([h_lp_re(:); h_ka_re(:)]);
ax1 = subplot(2,3,1);
s1 = scatter(lon_lp_re, lat_lp_re, 5, h_lp_re, 'filled');
s1.MarkerEdgeColor = 'k';
s1.MarkerFaceAlpha = 0.9;
hold on;  
[C1, h1] = contour(LON, LAT, HT, contour_levels, 'k-', 'LineWidth', 0.5);
clabel(C1, h1, 'FontSize', 8, 'Color', 'k');
c1 = colorbar('eastoutside');
c1.Label.String = 'Height (km)'; c1.Label.FontSize = 12;
caxis([hmin_re hmax_re])
xlim([295,310]); ylim([0,15]);
set(gca,'XTick',[295 300 305 310],'FontSize',13,'LineWidth',1);
xlabel('Longitude (°)','FontSize',14); ylabel('Latitude (°)','FontSize',14);
title('(a)LP — Reiner Gamma','FontSize',15,'FontWeight','bold','HorizontalAlignment','left','Position',[295,15.2,0]);
grid on; box on;
ax2 = subplot(2,3,2);
s2 = scatter(lon_ka_re, lat_ka_re, 5, h_ka_re, 'filled');
s2.MarkerEdgeColor = 'k';
s2.MarkerFaceAlpha = 0.9;
hold on;  
[C2, h2] = contour(LON, LAT, HT, contour_levels, 'k-', 'LineWidth', 0.5);
clabel(C2, h2, 'FontSize', 8, 'Color', 'k');
c2 = colorbar('eastoutside');
c2.Label.String = 'Height (km)'; c2.Label.FontSize = 12;
caxis([hmin_re hmax_re])
xlim([295,310]); ylim([0,15]);
set(gca,'XTick',[295 300 305 310],'FontSize',13,'LineWidth',1);
xlabel('Longitude (°)','FontSize',14); ylabel('Latitude (°)','FontSize',14);
title('(b)Kaguya — Reiner Gamma','FontSize',15,'FontWeight','bold','HorizontalAlignment','left','Position',[295,15.2,0]);
grid on; box on;
ax3 = subplot(2,3,3);
sp_lp_re = scatter(bt_lp_re, h_lp_re, 36, 'b', 'filled'); hold on
sp_lp_re.MarkerEdgeColor = 'k'; sp_lp_re.MarkerFaceAlpha = 0.7;
sp_ka_re = scatter(bt_ka_re, h_ka_re, 36, 'r', 'filled');
sp_ka_re.MarkerEdgeColor = 'k'; sp_ka_re.MarkerFaceAlpha = 0.7;
set(gca,'FontSize',13,'LineWidth',1);
xlabel('Bt (nT)','FontSize',14); ylabel('Height (km)','FontSize',14);
title('(c)Bt Height Profile — Reiner Gamma','FontSize',15,'FontWeight','bold','HorizontalAlignment','left','Position',[0,102,0]);
legend({'LP','Kaguya'},'FontSize',12,'Location','northeast','Box','off');
grid on; box on;
ylim([0 100]); 
hmin_rb = min([h_lp_rb(:); h_ka_rb(:)]);
hmax_rb = max([h_lp_rb(:); h_ka_rb(:)]);
ax4 = subplot(2,3,4);
s4 = scatter(lon_lp_rb, lat_lp_rb,5, h_lp_rb, 'filled');
s4.MarkerEdgeColor = 'k';
s4.MarkerFaceAlpha = 0.9;
hold on;  
[C4, h4] = contour(LON_RB, LAT_RB, HT_RB, contour_levels_rb, 'k-', 'LineWidth', 0.5);
clabel(C4, h4, 'FontSize', 8, 'Color', 'k');
c4 = colorbar('eastoutside');
c4.Label.String = 'Height (km)'; c4.Label.FontSize = 12;
caxis([hmin_rb hmax_rb])
xlim([350,365]); ylim([5,20]);
set(gca,'XTick',[350 355 360 365],'FontSize',13,'LineWidth',1);
set(gca,'XTickLabel',{'350','355','360','5'});
xlabel('Longitude (°)','FontSize',14); ylabel('Latitude (°)','FontSize',14);
title('(d)LP — Rima Bode','FontSize',15,'FontWeight','bold','HorizontalAlignment','left','Position',[350,20.2,0]);
grid on; box on;
ax5 = subplot(2,3,5);
s5 = scatter(lon_ka_rb, lat_ka_rb, 5, h_ka_rb, 'filled');
s5.MarkerEdgeColor = 'k';
s5.MarkerFaceAlpha = 0.9;
hold on;  
[C5, h5] = contour(LON_RB, LAT_RB, HT_RB, contour_levels_rb, 'k-', 'LineWidth', 0.5);
clabel(C5, h5, 'FontSize', 8, 'Color', 'k');
c5 = colorbar('eastoutside');
c5.Label.String = 'Height (km)'; c5.Label.FontSize = 12;
caxis([hmin_rb hmax_rb])
xlim([350,365]); ylim([5,20]);
set(gca,'XTick',[350 355 360 365],'FontSize',13,'LineWidth',1);
set(gca,'XTickLabel',{'350','355','360','5'});
xlabel('Longitude (°)','FontSize',14); ylabel('Latitude (°)','FontSize',14);
title('(e)Kaguya — Rima Bode','FontSize',15,'FontWeight','bold','HorizontalAlignment','left','Position',[350,20.2,0]);
grid on; box on;
ax6 = subplot(2,3,6);
sp_lp_rb = scatter(bt_lp_rb, h_lp_rb, 36, 'b', 'filled'); hold on
sp_lp_rb.MarkerEdgeColor = 'k'; sp_lp_rb.MarkerFaceAlpha = 0.7;
sp_ka_rb = scatter(bt_ka_rb, h_ka_rb, 36, 'r', 'filled');
sp_ka_rb.MarkerEdgeColor = 'k'; sp_ka_rb.MarkerFaceAlpha = 0.7;
set(gca,'FontSize',13,'LineWidth',1);
xlabel('Bt (nT)','FontSize',14); ylabel('Height (km)','FontSize',14);
title('(f)Bt Height Profile — Rima Bode','FontSize',15,'FontWeight','bold','HorizontalAlignment','left','Position',[0,102,0]);
legend({'LP','Kaguya'},'FontSize',12,'Location','northeast','Box','off');
grid on; box on;
ylim([0 100]);
colormap(mapcmap)
c1.FontSize = 11; c2.FontSize = 11; c4.FontSize = 11; c5.FontSize = 11;
if exist('tightfig','file')==2
    tightfig; 
end