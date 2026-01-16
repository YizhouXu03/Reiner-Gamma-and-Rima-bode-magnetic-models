clear; clc; close all;
R_moon = 1737.4;      
depth = 0.2;         
grid_spacing = 0.3;   
mu0 = 4 * pi * 1e-7;  
d2r = pi/180;         
B_ancient = 80e-6;    
H_ancient = B_ancient / mu0;  
Jmin_rg = 295; Jmax_rg = 310; 
Wmin_rg = 0; Wmax_rg = 15;
jian = 0.3;
dw = 0.3;
load Xk_fixed.mat
A_rg = [];
for j = (Jmin_rg-jian):dw:(Jmax_rg+jian-dw)
    for w = (Wmin_rg-jian):dw:(Wmax_rg+jian-dw)
        J = j + dw/2;
        W = w + dw/2;
        A_rg = [A_rg; J, W, 0];  
    end
end
lon_rg = A_rg(:,1);
lat_rg = A_rg(:,2);
lon_grid_rg = reshape(lon_rg, 52, 52);
lat_grid_rg = reshape(lat_rg, 52, 52);
n_rg = length(Xk_fixed)/3;
Mx_rg = Xk_fixed(1:n_rg);
My_rg = Xk_fixed(n_rg+1:2*n_rg);
Mz_rg = Xk_fixed(2*n_rg+1:3*n_rg);
Mx_grid_rg = reshape(Mx_rg, 52, 52);
My_grid_rg = reshape(My_rg, 52, 52);
Mz_grid_rg = reshape(Mz_rg, 52, 52);
lat_rad_rg = lat_grid_rg * d2r;
lon_rad_rg = lon_grid_rg * d2r;
dlon = grid_spacing * d2r;
dlat = grid_spacing * d2r;
lat1_rad_rg = lat_rad_rg - dlat/2;
lat2_rad_rg = lat_rad_rg + dlat/2;
area_rg = (R_moon * 1000)^2 * dlon .* abs(sin(lat2_rad_rg) - sin(lat1_rad_rg));
volume_rg = area_rg * (depth * 1000);  
M_magnitude_rg = sqrt(Mx_grid_rg.^2 + My_grid_rg.^2 + Mz_grid_rg.^2);  % A*m^2
M_intensity_rg = M_magnitude_rg ./ volume_rg;
chi_rg = M_intensity_rg ./ H_ancient;
chi_rg(isinf(chi_rg) | isnan(chi_rg)) = 0;
chi_rg(chi_rg > 5) = 5;  
chi_rg(chi_rg < 0) = 0;
Jmin_rb = 350; Jmax_rb = 365;   
Wmin_rb = 5; Wmax_rb = 20;
load Xk_fixedrb.mat
jian = 0.3;
dw = 0.3;
A_rb = [];
for j = (Jmin_rb-jian):dw:(Jmax_rb+jian-dw)
    for w = (Wmin_rb-jian):dw:(Wmax_rb+jian-dw)
        J = j + dw/2;
        W = w + dw/2;
        A_rb = [A_rb; J, W, 0];  
    end
end
lon_rb = A_rb(:,1);
lat_rb = A_rb(:,2);
lon_rb(lon_rb<300)=lon_rb(lon_rb<300)+360;
lon_grid_rb = reshape(lon_rb, 52, 52);
lat_grid_rb = reshape(lat_rb, 52, 52);
n_rb = length(Xk_fixedrb)/3;
Mx_rb = Xk_fixedrb(1:n_rb);
My_rb = Xk_fixedrb(n_rb+1:2*n_rb);
Mz_rb = Xk_fixedrb(2*n_rb+1:3*n_rb);
Mx_grid_rb = reshape(Mx_rb, 52, 52);
My_grid_rb = reshape(My_rb, 52, 52);
Mz_grid_rb = reshape(Mz_rb, 52, 52);
lat_rad_rb = lat_grid_rb * d2r;
lon_rad_rb = lon_grid_rb * d2r;
lat1_rad_rb = lat_rad_rb - dlat/2;
lat2_rad_rb = lat_rad_rb + dlat/2;
area_rb = (R_moon * 1000)^2 * dlon .* abs(sin(lat2_rad_rb) - sin(lat1_rad_rb));
volume_rb = area_rb * (depth * 1000);
M_magnitude_rb = sqrt(Mx_grid_rb.^2 + My_grid_rb.^2 + Mz_grid_rb.^2);
M_intensity_rb = M_magnitude_rb ./ volume_rb;
chi_rb = M_intensity_rb ./ H_ancient;
chi_rb(isinf(chi_rb) | isnan(chi_rb)) = 0;
chi_rb(chi_rb > 5) = 5;
chi_rb(chi_rb < 0) = 0;
figure('Position', [100, 100, 1200, 500]);
subplot(1, 2, 1);
h1 = pcolor(lon_grid_rg, lat_grid_rg, chi_rg);
set(h1, 'EdgeColor', 'none');
colormap('jet');
cbar1 = colorbar;
cbar1.Label.String = 'Magnetic Susceptibility \chi';
cbar1.Label.FontSize = 12;
xlabel('Longitude (°)', 'FontSize', 14);
ylabel('Latitude (°)', 'FontSize', 14);
x_limits = xlim;
y_limits = ylim;
title_x = x_limits(1) + 0.05 * (x_limits(2) - x_limits(1))-0.5;
title_y = y_limits(2) - 0.00001 * (y_limits(2) - y_limits(1))+1;
text(title_x, title_y, '(a) Reiner Gamma', ...
    'FontSize', 12, 'FontWeight', 'bold', ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
grid on;
axis equal tight;
set(gca, 'FontSize', 11);
xlim([Jmin_rg, Jmax_rg]);
ylim([Wmin_rg, Wmax_rg]);
subplot(1, 2, 2);
lon_grid_rb(lon_grid_rb<300) = lon_grid_rb(lon_grid_rb<300) + 360;
h2 = pcolor(lon_grid_rb, lat_grid_rb, chi_rb);
set(h2, 'EdgeColor', 'none');
colormap('jet');
cbar2 = colorbar;
cbar2.Label.String = 'Magnetic Susceptibility \chi';
cbar2.Label.FontSize = 12;
xlabel('Longitude (°)', 'FontSize', 14);
ylabel('Latitude (°)', 'FontSize', 14);
x_limits = xlim;
y_limits = ylim;
title_x = x_limits(1) + 0.05 * (x_limits(2) - x_limits(1))-0.5;
title_y = y_limits(2) - 0.00001 * (y_limits(2) - y_limits(1))+1;
text(title_x, title_y, '(b) Rima Bode', ...
    'FontSize', 12, 'FontWeight', 'bold', ...
    'VerticalAlignment', 'top', 'HorizontalAlignment', 'left');
grid on;
axis equal tight;
set(gca, 'FontSize', 11);
xlim([Jmin_rb, 365]);  
ylim([5, 20]);
set(gca, 'XTick', [350, 355, 360, 365]);
set(gca, 'XTickLabel', {'350°', '355°', '360°', '5°'});
print('magnetic_susceptibility_comparison.png', '-dpng', '-r300');
high_chi_rg = chi_rg > 0.5;
high_chi_rb = chi_rb > 0.5;
save('calculated_susceptibility_comparison.mat', ...
    'lon_grid_rg', 'lat_grid_rg', 'chi_rg', 'M_intensity_rg', ...
    'lon_grid_rb', 'lat_grid_rb', 'chi_rb', 'M_intensity_rb', ...
    'depth', 'B_ancient');