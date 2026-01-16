clear; clc;
set(0,'defaultfigurecolor','w');
load mycolormap3.mat
myColormap = mycolormap3;
load bpc_xyzrb.mat
lon = bpc_xyzrb(:,1);
lon(lon<10)=lon(lon<10)+360;
lat = bpc_xyzrb(:,2);
h = ones(size(lon))*0;
A = [lon,lat,h];
C = weizhi(A);
x = C(:,1); y = C(:,2); z = C(:,3);
bx = bpc_xyzrb(:,3); by = bpc_xyzrb(:,4); bz = bpc_xyzrb(:,5);
[br, bt, bp] = convert_B_xyz_to_sph(x, y, z, bx, by, bz);
btotal = sqrt(br.^2 + bt.^2 + bp.^2);
in1 = readtable('r20_0kmrbl.txt','VariableNamingRule','preserve');
br1 = reshape(table2array(in1(:,1)),151,151);
bt1 = reshape(table2array(in1(:,2)),151,151);
bp1 = reshape(table2array(in1(:,3)),151,151);
btotal1 = sqrt(br1.^2 + bt1.^2 + bp1.^2);
in2 = readtable('t15_0kmrbl.txt','VariableNamingRule','preserve');
br2 = reshape(table2array(in2(:,1)),151,151);
bt2 = reshape(table2array(in2(:,2)),151,151);
bp2 = reshape(table2array(in2(:,3)),151,151);
btotal2 = sqrt(br2.^2 + bt2.^2 + bp2.^2);
lon = reshape(lon,151,151);
lat = reshape(lat,151,151);
br = reshape(br,151,151);
bt = reshape(bt,151,151);
bp = reshape(bp,151,151);
btotal = reshape(btotal,151,151);
fields_all = {br, bt, bp, btotal; br1, bt1, bp1, btotal1; br2, bt2, bp2, btotal2};
titles = {'B_r','B_\theta','B_\phi','B_{total}'};
figure('Position',[150 50 1200 900]);
for row = 1:3
    for col = 1:4
        subplot(3,4,(row-1)*4+col)
        pcolor(lon,lat,fields_all{row,col});
        shading interp; axis equal tight;
        colormap(myColormap);
        xlabel('Longitude (°)','FontSize',13,'FontWeight','bold');
        ylabel('Latitude (°)','FontSize',13,'FontWeight','bold');
        set(gca, 'XTick', [350, 355, 360, 365]);
        set(gca, 'XTickLabel', {'350', '355', '360', '5'});
        title(titles{col},'FontSize',13,'FontWeight','bold');
        cb = colorbar; cb.Label.String = 'nT'; cb.Label.FontSize = 12;
        if col < 4, caxis([-5 5]); else, caxis([0 5]); end
    end
end
annotation('textbox', [0.32, 0.93, 0.4, 0.05], 'String', 'This Model',...
    'EdgeColor','none','HorizontalAlignment','center','FontSize',15,'FontWeight','bold');
annotation('textbox', [0.32, 0.63, 0.4, 0.05], 'String', 'R20 Model',...
    'EdgeColor','none','HorizontalAlignment','center','FontSize',15,'FontWeight','bold');
annotation('textbox', [0.32, 0.33, 0.4, 0.05], 'String', 'T15 Model',...
    'EdgeColor','none','HorizontalAlignment','center','FontSize',15,'FontWeight','bold');