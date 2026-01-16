clear; clc;
set(0,'defaultfigurecolor','w')
fontSize = 14;
figure('Position',[100 100 1200 900])
load Xk_fixedrg.mat    
Xk_fixedrg = Xk_fixed;
Jmin=295; Jmax=310; Wmin=0; Wmax=15; h=-15;
dw=0.3; jian=0.3;
A1=[];
for j=(Jmin-jian):dw:(Jmax+jian-dw)
    for w=(Wmin-jian):dw:(Wmax+jian-dw)
        A1=[A1; j+dw/2, w+dw/2, h];
    end
end
A=A1; 
x=A(:,1); y=A(:,2); z=A(:,3);
n = size(A, 1);  
Mx=Xk_fixedrg(1:n); 
My=Xk_fixedrg(n+1:2*n); 
Mz=Xk_fixedrg(2*n+1:3*n);
magnitude = sqrt(Mx.^2 + My.^2 + Mz.^2);  
subplot(2,2,1)
scatter3(x, y, z, 10, magnitude, 'filled');
xlabel('Longitude (°E)','FontSize',fontSize);
ylabel('Latitude (°N)','FontSize',fontSize);
zlabel('Depth (km)','FontSize',fontSize);
xlim([295,310]); ylim([0,15]); zlim([-30,0]);
set(gca, ...
    'ZTick', [-30, -20, -10, 0], ...  
    'ZTickLabel', {'30', '20', '10', '0'}, ...  
    'FontSize', fontSize);
text(-0.15, 1.05, '(a) Reiner Gamma: Dipole Magnitude', ...
    'Units', 'normalized', ...
    'FontSize', fontSize+1, ...
    'FontWeight', 'bold', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'bottom');
view(30,30)
colormap('jet')
cb=colorbar;
ylabel(cb,'|m|(A·m^{2})','FontSize',fontSize,'Rotation',0)
grid on; box on;
subplot(2,2,3)
quiver3(x, y, z, Mx, My, Mz, 'AutoScaleFactor',1.2,'Color',[0.2 0.2 0.8]);
xlabel('Longitude (°E)','FontSize',fontSize);
ylabel('Latitude (°N)','FontSize',fontSize);
zlabel('Depth (km)','FontSize',fontSize);
xlim([295,310]); ylim([0,15]); zlim([-30,0]);
set(gca, ...
    'ZTick', [-30, -20, -10, 0], ...
    'ZTickLabel', {'30', '20', '10', '0'}, ...
    'FontSize', fontSize);
text(-0.1, 1.05, '(c) Reiner Gamma: Dipole Direction', ...
    'Units', 'normalized', ...
    'FontSize', fontSize+1, ...
    'FontWeight', 'bold', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'bottom');
view(30,30)
grid on; box on;
clear Xk_fixed
load Xk_fixed.mat     
Jmin=350; Jmax=365; Wmin=5; Wmax=20; h=-15;
dw=0.3; jian=0.3;
A1=[];
for j=(Jmin-jian):dw:(Jmax+jian-dw)
    for w=(Wmin-jian):dw:(Wmax+jian-dw)
        A1=[A1; j+dw/2, w+dw/2, h];
    end
end
A=A1; 
x=A(:,1); y=A(:,2); z=A(:,3);
n = size(A, 1);  
Mx=Xk_fixed(1:n); 
My=Xk_fixed(n+1:2*n); 
Mz=Xk_fixed(2*n+1:3*n);
magnitude = sqrt(Mx.^2 + My.^2 + Mz.^2);  
subplot(2,2,2)
scatter3(x, y, z, 10, magnitude, 'filled');
xlabel('Longitude (°E)','FontSize',fontSize);
ylabel('Latitude (°N)','FontSize',fontSize);
zlabel('Depth (km)','FontSize',fontSize);
xlim([350,365]); ylim([5,20]); zlim([-30,0]);
set(gca,'XTick',[350 355 360 365],'XTickLabel',{'350','355','360','5'})
set(gca, ...
    'ZTick', [-30, -20, -10, 0], ...
    'ZTickLabel', {'30', '20', '10', '0'}, ...
    'FontSize', fontSize);
text(-0.15, 1.05, '(b) Rima Bode: Dipole Magnitude', ...
    'Units', 'normalized', ...
    'FontSize', fontSize+1, ...
    'FontWeight', 'bold', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'bottom');
view(30,30)
colormap('jet')
cb=colorbar;
ylabel(cb,'|m|(A·m^{2})','FontSize',fontSize,'Rotation',0)
grid on; box on;
subplot(2,2,4)
quiver3(x, y, z, Mx, My, Mz, 'AutoScaleFactor',1.2,'Color',[0.2 0.2 0.8]);
xlabel('Longitude (°E)','FontSize',fontSize);
ylabel('Latitude (°N)','FontSize',fontSize);
zlabel('Depth (km)','FontSize',fontSize);
xlim([350,365]); ylim([5,20]); zlim([-30,0]);
set(gca,'XTick',[350 355 360 365],'XTickLabel',{'350','355','360','5'})
set(gca, ...
    'ZTick', [-30, -20, -10, 0], ...
    'ZTickLabel', {'30', '20', '10', '0'}, ...
    'FontSize', fontSize);
text(-0.1, 1.05, '(d) Rima Bode: Dipole Direction', ...
    'Units', 'normalized', ...
    'FontSize', fontSize+1, ...
    'FontWeight', 'bold', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'bottom');
view(30,30)
grid on; box on;