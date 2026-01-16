clear; clc; close all;
set(0, 'DefaultFigureColor', 'w', 'DefaultAxesFontSize', 13);
load test_lptanikani50rgde.mat
lon_rg = test_lptanikani50rgde(:,1); 
lat_rg = test_lptanikani50rgde(:,2); 
h_rg = test_lptanikani50rgde(:,3);
bdx_rg = test_lptanikani50rgde(:,4); 
bdy_rg = test_lptanikani50rgde(:,5); 
bdz_rg = test_lptanikani50rgde(:,6);
load bm_xyz.mat
bmx_rg = bm_xyz(:,4); 
bmy_rg = bm_xyz(:,5); 
bmz_rg = bm_xyz(:,6);
in_rg = readtable('testrgr20.txt');
brr_rg = table2array(in_rg(:,1)); brt_rg = table2array(in_rg(:,2)); brp_rg = table2array(in_rg(:,3));
in2_rg = readtable('testrgt15.txt');
btr_rg = table2array(in2_rg(:,1)); btt_rg = table2array(in2_rg(:,2)); btp_rg = table2array(in2_rg(:,3));
load test_lptanikani50rbde.mat
lon_rb = test_lptanikani50rbde(:,1); 
lat_rb = test_lptanikani50rbde(:,2); 
h_rb = test_lptanikani50rbde(:,3);
bdx_rb = test_lptanikani50rbde(:,4); 
bdy_rb = test_lptanikani50rbde(:,5); 
bdz_rb = test_lptanikani50rbde(:,6);
load bm_xyzrb.mat
bmx_rb = bm_xyzrb(:,3); 
bmy_rb = bm_xyzrb(:,4); 
bmz_rb = bm_xyzrb(:,5);
in_rb = readtable('testrbr20.txt');
brr_rb = table2array(in_rb(:,1)); brt_rb = table2array(in_rb(:,2)); brp_rb = table2array(in_rb(:,3));
in2_rb = readtable('testrbt15.txt');
btr_rb = table2array(in2_rb(:,1)); btt_rb = table2array(in2_rb(:,2)); btp_rb = table2array(in2_rb(:,3));
lon_rad_rg = deg2rad(lon_rg);
lat_rad_rg = deg2rad(lat_rg);
colat_rg = pi/2 - lat_rad_rg;
toXYZ = @(Br,Bt,Bp,lon_rad,colat) deal( Br.*sin(colat).*cos(lon_rad) + Bt.*cos(colat).*cos(lon_rad) - Bp.*sin(lon_rad), Br.*sin(colat).*sin(lon_rad) + Bt.*cos(colat).*sin(lon_rad) + Bp.*cos(lon_rad), Br.*cos(colat) - Bt.*sin(colat));
[brx_rg,bry_rg,brz_rg] = toXYZ(brr_rg,brt_rg,brp_rg,lon_rad_rg,colat_rg);
[btx_rg,bty_rg,btz_rg] = toXYZ(btr_rg,btt_rg,btp_rg,lon_rad_rg,colat_rg);
lon_rad_rb = deg2rad(lon_rb);
lat_rad_rb = deg2rad(lat_rb);
colat_rb = pi/2 - lat_rad_rb;
[brx_rb,bry_rb,brz_rb] = toXYZ(brr_rb,brt_rb,brp_rb,lon_rad_rb,colat_rb);
[btx_rb,bty_rb,btz_rb] = toXYZ(btr_rb,btt_rb,btp_rb,lon_rad_rb,colat_rb);
rmx_rg = bdx_rg - bmx_rg; rmy_rg = bdy_rg - bmy_rg; rmz_rg = bdz_rg - bmz_rg;   
rrx_rg = bdx_rg - brx_rg; rry_rg = bdy_rg - bry_rg; rrz_rg = bdz_rg - brz_rg;   
rtx_rg = bdx_rg - btx_rg; rty_rg = bdy_rg - bty_rg; rtz_rg = bdz_rg - btz_rg;   
rmx_rb = bdx_rb - bmx_rb; rmy_rb = bdy_rb - bmy_rb; rmz_rb = bdz_rb - bmz_rb;  
rrx_rb = bdx_rb - brx_rb; rry_rb = bdy_rb - bry_rb; rrz_rb = bdz_rb - brz_rb;   
rtx_rb = bdx_rb - btx_rb; rty_rb = bdy_rb - bty_rb; rtz_rb = bdz_rb - btz_rb;  
models = {'Our Model', 'R20', 'T15'};
components = {'X', 'Y', 'Z'};
stats_rg = struct();
stats_rg.rm.rms = [sqrt(mean(rmx_rg.^2)), sqrt(mean(rmy_rg.^2)), sqrt(mean(rmz_rg.^2))];
stats_rg.rm.mean = [mean(rmx_rg), mean(rmy_rg), mean(rmz_rg)];
stats_rg.rm.std = [std(rmx_rg), std(rmy_rg), std(rmz_rg)];
stats_rg.rr.rms = [sqrt(mean(rrx_rg.^2)), sqrt(mean(rry_rg.^2)), sqrt(mean(rrz_rg.^2))];
stats_rg.rr.mean = [mean(rrx_rg), mean(rry_rg), mean(rrz_rg)];
stats_rg.rr.std = [std(rrx_rg), std(rry_rg), std(rrz_rg)];
stats_rg.rt.rms = [sqrt(mean(rtx_rg.^2)), sqrt(mean(rty_rg.^2)), sqrt(mean(rtz_rg.^2))];
stats_rg.rt.mean = [mean(rtx_rg), mean(rty_rg), mean(rtz_rg)];
stats_rg.rt.std = [std(rtx_rg), std(rty_rg), std(rtz_rg)];
stats_rb = struct();
stats_rb.rm.rms = [sqrt(mean(rmx_rb.^2)), sqrt(mean(rmy_rb.^2)), sqrt(mean(rmz_rb.^2))];
stats_rb.rm.mean = [mean(rmx_rb), mean(rmy_rb), mean(rmz_rb)];
stats_rb.rm.std = [std(rmx_rb), std(rmy_rb), std(rmz_rb)];
stats_rb.rr.rms = [sqrt(mean(rrx_rb.^2)), sqrt(mean(rry_rb.^2)), sqrt(mean(rrz_rb.^2))];
stats_rb.rr.mean = [mean(rrx_rb), mean(rry_rb), mean(rrz_rb)];
stats_rb.rr.std = [std(rrx_rb), std(rry_rb), std(rrz_rb)];
stats_rb.rt.rms = [sqrt(mean(rtx_rb.^2)), sqrt(mean(rty_rb.^2)), sqrt(mean(rtz_rb.^2))];
stats_rb.rt.mean = [mean(rtx_rb), mean(rty_rb), mean(rtz_rb)];
stats_rb.rt.std = [std(rtx_rb), std(rty_rb), std(rtz_rb)];
figure('Position', [100, 100, 1400, 1200]);
colors = [0.8500 0.3250 0.0980;  
          0      0.4470 0.7410;  
          0.4660 0.6740 0.1880]; 
annotation('textbox', [0.1, 0.94, 0.8, 0.04],  'String', 'Reiner Gamma', 'FontSize', 14, 'FontWeight', 'bold', 'EdgeColor', 'none', 'HorizontalAlignment', 'center');
subplot(4, 3, 1);
hold on;
x_range_rg = linspace(min([rmx_rg; rrx_rg; rtx_rg]), max([rmx_rg; rrx_rg; rtx_rg]), 200);
plot(x_range_rg, normpdf(x_range_rg, stats_rg.rm.mean(1), stats_rg.rm.std(1)), 'Color', colors(1,:), 'LineWidth', 2.5, 'DisplayName', 'Our Model');
plot(x_range_rg, normpdf(x_range_rg, stats_rg.rr.mean(1), stats_rg.rr.std(1)), 'Color', colors(2,:), 'LineWidth', 2.5, 'DisplayName', 'R20');
plot(x_range_rg, normpdf(x_range_rg, stats_rg.rt.mean(1), stats_rg.rt.std(1)), 'Color', colors(3,:), 'LineWidth', 2.5, 'DisplayName', 'T15');
xlabel('Residual (nT)');
ylabel('Probability Density');
xlim([-20, 20]);
ylim([0, 0.4]);
title('(a) B_X', 'FontWeight', 'bold', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'Position', [-20, 0.42], 'Units', 'data');
lg = legend('show', 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
box on;
set(gca, 'FontSize', 11);
subplot(4, 3, 2);
hold on;
y_range_rg = linspace(min([rmy_rg; rry_rg; rty_rg]), max([rmy_rg; rry_rg; rty_rg]), 200);
plot(y_range_rg, normpdf(y_range_rg, stats_rg.rm.mean(2), stats_rg.rm.std(2)), ...
     'Color', colors(1,:), 'LineWidth', 2.5, 'DisplayName', 'Our Model');
plot(y_range_rg, normpdf(y_range_rg, stats_rg.rr.mean(2), stats_rg.rr.std(2)), ...
     'Color', colors(2,:), 'LineWidth', 2.5, 'DisplayName', 'R20');
plot(y_range_rg, normpdf(y_range_rg, stats_rg.rt.mean(2), stats_rg.rt.std(2)), ...
     'Color', colors(3,:), 'LineWidth', 2.5, 'DisplayName', 'T15');
xlabel('Residual (nT)');
ylabel('Probability Density');
xlim([-20, 20]);
ylim([0, 0.4]);
title('(b) B_Y', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [-20, 0.42], ...
      'Units', 'data');
lg = legend('show', 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
box on;
set(gca, 'FontSize', 11);
subplot(4, 3, 3);
hold on;
z_range_rg = linspace(min([rmz_rg; rrz_rg; rtz_rg]), max([rmz_rg; rrz_rg; rtz_rg]), 200);
plot(z_range_rg, normpdf(z_range_rg, stats_rg.rm.mean(3), stats_rg.rm.std(3)), ...
     'Color', colors(1,:), 'LineWidth', 2.5, 'DisplayName', 'Our Model');
plot(z_range_rg, normpdf(z_range_rg, stats_rg.rr.mean(3), stats_rg.rr.std(3)), ...
     'Color', colors(2,:), 'LineWidth', 2.5, 'DisplayName', 'R20');
plot(z_range_rg, normpdf(z_range_rg, stats_rg.rt.mean(3), stats_rg.rt.std(3)), ...
     'Color', colors(3,:), 'LineWidth', 2.5, 'DisplayName', 'T15');
xlabel('Residual (nT)');
ylabel('Probability Density');
xlim([-20, 20]);
ylim([0, 0.4]);
title('(c) B_Z', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [-20, 0.42], ...
      'Units', 'data');
lg = legend('show', 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
box on;
set(gca, 'FontSize', 11);
subplot(4, 3, 4);
rms_data_rg = [stats_rg.rm.rms; stats_rg.rr.rms; stats_rg.rt.rms]';
b = bar(rms_data_rg, 'grouped');
for i = 1:length(b)
    b(i).FaceColor = colors(i,:);
    b(i).FaceAlpha = 0.8;
end
ylabel('RMS (nT)');
x_lim = xlim; y_lim = ylim;
title('(d) RMS', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [x_lim(1), y_lim(2)], ...
      'Units', 'data');
set(gca, 'XTickLabel', components);
lg = legend(models, 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
set(gca, 'FontSize', 11);
subplot(4, 3, 5);
mean_data_rg = [stats_rg.rm.mean; stats_rg.rr.mean; stats_rg.rt.mean]';
b = bar(mean_data_rg, 'grouped');
for i = 1:length(b)
    b(i).FaceColor = colors(i,:);
    b(i).FaceAlpha = 0.8;
end
ylabel('Mean (nT)');
x_lim = xlim; y_lim = ylim;
title('(e) Mean', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [x_lim(1), y_lim(2)*0.9], ...
      'Units', 'data');
set(gca, 'XTickLabel', components);
lg = legend(models, 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
set(gca, 'FontSize', 11);
subplot(4, 3, 6);
std_data_rg = [stats_rg.rm.std; stats_rg.rr.std; stats_rg.rt.std]';
b = bar(std_data_rg, 'grouped');
for i = 1:length(b)
    b(i).FaceColor = colors(i,:);
    b(i).FaceAlpha = 0.8;
end
ylabel('Std (nT)');
x_lim = xlim; y_lim = ylim;
title('(f) Standard Deviation', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [x_lim(1), y_lim(2)], ...
      'Units', 'data');
set(gca, 'XTickLabel', components);
lg = legend(models, 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
set(gca, 'FontSize', 11);
annotation('textbox', [0.1, 0.5, 0.8, 0.04], ...
    'String', 'Rima Bode', ...
    'FontSize', 14, 'FontWeight', 'bold', ...
    'EdgeColor', 'none', 'HorizontalAlignment', 'center');
subplot(4, 3, 7);
hold on;
x_range_rb = linspace(min([rmx_rb; rrx_rb; rtx_rb]), max([rmx_rb; rrx_rb; rtx_rb]), 200);
plot(x_range_rb, normpdf(x_range_rb, stats_rb.rm.mean(1), stats_rb.rm.std(1)), ...
     'Color', colors(1,:), 'LineWidth', 2.5, 'DisplayName', 'Our Model');
plot(x_range_rb, normpdf(x_range_rb, stats_rb.rr.mean(1), stats_rb.rr.std(1)), ...
     'Color', colors(2,:), 'LineWidth', 2.5, 'DisplayName', 'R20');
plot(x_range_rb, normpdf(x_range_rb, stats_rb.rt.mean(1), stats_rb.rt.std(1)), ...
     'Color', colors(3,:), 'LineWidth', 2.5, 'DisplayName', 'T15');
xlabel('Residual (nT)');
ylabel('Probability Density');
xlim([-20, 20]);
ylim([0, 0.45]);
title('(g) B_X', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [-20, 0.45], ...
      'Units', 'data');
lg = legend('show', 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
box on;
set(gca, 'FontSize', 11);
subplot(4, 3, 8);
hold on;
y_range_rb = linspace(min([rmy_rb; rry_rb; rty_rb]), max([rmy_rb; rry_rb; rty_rb]), 200);
plot(y_range_rb, normpdf(y_range_rb, stats_rb.rm.mean(2), stats_rb.rm.std(2)), ...
     'Color', colors(1,:), 'LineWidth', 2.5, 'DisplayName', 'Our Model');
plot(y_range_rb, normpdf(y_range_rb, stats_rb.rr.mean(2), stats_rb.rr.std(2)), ...
     'Color', colors(2,:), 'LineWidth', 2.5, 'DisplayName', 'R20');
plot(y_range_rb, normpdf(y_range_rb, stats_rb.rt.mean(2), stats_rb.rt.std(2)), ...
     'Color', colors(3,:), 'LineWidth', 2.5, 'DisplayName', 'T15');
xlabel('Residual (nT)');
ylabel('Probability Density');
xlim([-20, 20]);
ylim([0, 0.45]);
title('(h) B_Y', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [-20, 0.45], ...
      'Units', 'data');
lg = legend('show', 'Location', 'northeast');
set(lg, 'FontSize', 9);
grid on;
box on;
set(gca, 'FontSize', 11);
subplot(4, 3, 9);
hold on;
z_range_rb = linspace(min([rmz_rb; rrz_rb; rtz_rb]), max([rmz_rb; rrz_rb; rtz_rb]), 200);
plot(z_range_rb, normpdf(z_range_rb, stats_rb.rm.mean(3), stats_rb.rm.std(3)), ...
     'Color', colors(1,:), 'LineWidth', 2.5, 'DisplayName', 'Our Model');
plot(z_range_rb, normpdf(z_range_rb, stats_rb.rr.mean(3), stats_rb.rr.std(3)), ...
     'Color', colors(2,:), 'LineWidth', 2.5, 'DisplayName', 'R20');
plot(z_range_rb, normpdf(z_range_rb, stats_rb.rt.mean(3), stats_rb.rt.std(3)), ...
     'Color', colors(3,:), 'LineWidth', 2.5, 'DisplayName', 'T15');
xlabel('Residual (nT)');
ylabel('Probability Density');
xlim([-20, 20]);
ylim([0, 0.45]);
title('(i) B_Z', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [-20, 0.45], ...
      'Units', 'data');
lg = legend('show', 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
box on;
set(gca, 'FontSize', 11);
subplot(4, 3, 10);
rms_data_rb = [stats_rb.rm.rms; stats_rb.rr.rms; stats_rb.rt.rms]';
b = bar(rms_data_rb, 'grouped');
for i = 1:length(b)
    b(i).FaceColor = colors(i,:);
    b(i).FaceAlpha = 0.8;
end
ylabel('RMS (nT)');
x_lim = xlim; y_lim = ylim;
title('(j) RMS', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [x_lim(1), y_lim(2)], ...
      'Units', 'data');
set(gca, 'XTickLabel', components);
lg = legend(models, 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
set(gca, 'FontSize', 11);
subplot(4, 3, 11);
mean_data_rb = [stats_rb.rm.mean; stats_rb.rr.mean; stats_rb.rt.mean]';
b = bar(mean_data_rb, 'grouped');
for i = 1:length(b)
    b(i).FaceColor = colors(i,:);
    b(i).FaceAlpha = 0.8;
end
ylabel('Mean (nT)');
x_lim = xlim; y_lim = ylim;
title('(k) Mean', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [x_lim(1), y_lim(2)*0.85], ...
      'Units', 'data');
set(gca, 'XTickLabel', components);
lg = legend(models, 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
set(gca, 'FontSize', 11);
subplot(4, 3, 12);
std_data_rb = [stats_rb.rm.std; stats_rb.rr.std; stats_rb.rt.std]';
b = bar(std_data_rb, 'grouped');
for i = 1:length(b)
    b(i).FaceColor = colors(i,:);
    b(i).FaceAlpha = 0.8;
end
ylabel('Std (nT)');
x_lim = xlim; y_lim = ylim;
title('(l) Standard Deviation', 'FontWeight', 'bold', ...
      'HorizontalAlignment', 'left', ...
      'VerticalAlignment', 'bottom', ...
      'Position', [x_lim(1), y_lim(2)], ...
      'Units', 'data');
set(gca, 'XTickLabel', components);
lg = legend(models, 'Location', 'northeast');
set(lg, 'FontSize', 9); 
grid on;
set(gca, 'FontSize', 11);
set(gcf, 'Position', [100, 100, 1400, 1200]);
print(gcf, 'Combined_Residual_Analysis_4x3_small_legend_left_title', '-dpng', '-r300');
saveas(gcf, 'Combined_Residual_Analysis_4x3_small_legend_left_title.fig');
fprintf('\n=== Reiner Gamma Residual Statistics ===\n');
fprintf('Model\t\tComponent\tRMS (nT)\tMean (nT)\tStd (nT)\n');
fprintf('------------------------------------------------------------\n');
for i = 1:3
    for j = 1:3
        switch i
            case 1
                model_name = 'Our Model';
                rms_val = stats_rg.rm.rms(j);
                mean_val = stats_rg.rm.mean(j);
                std_val = stats_rg.rm.std(j);
            case 2
                model_name = 'R20     ';
                rms_val = stats_rg.rr.rms(j);
                mean_val = stats_rg.rr.mean(j);
                std_val = stats_rg.rr.std(j);
            case 3
                model_name = 'T15     ';
                rms_val = stats_rg.rt.rms(j);
                mean_val = stats_rg.rt.mean(j);
                std_val = stats_rg.rt.std(j);
        end
        fprintf('%s\t\tB_%s\t\t%.2f\t\t%.2f\t\t%.2f\n', model_name, components{j}, rms_val, mean_val, std_val);
    end
end
fprintf('\n=== Rima Bode Residual Statistics ===\n');
fprintf('Model\t\tComponent\tRMS (nT)\tMean (nT)\tStd (nT)\n');
fprintf('------------------------------------------------------------\n');
for i = 1:3
    for j = 1:3
        switch i
            case 1
                model_name = 'Our Model';
                rms_val = stats_rb.rm.rms(j);
                mean_val = stats_rb.rm.mean(j);
                std_val = stats_rb.rm.std(j);
            case 2
                model_name = 'R20     ';
                rms_val = stats_rb.rr.rms(j);
                mean_val = stats_rb.rr.mean(j);
                std_val = stats_rb.rr.std(j);
            case 3
                model_name = 'T15     ';
                rms_val = stats_rb.rt.rms(j);
                mean_val = stats_rb.rt.mean(j);
                std_val = stats_rb.rt.std(j);
        end
        fprintf('%s\t\tB_%s\t\t%.2f\t\t%.2f\t\t%.2f\n', model_name, components{j}, rms_val, mean_val, std_val);
    end
end