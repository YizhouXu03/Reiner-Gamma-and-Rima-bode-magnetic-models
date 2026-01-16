clear; close all; clc;
error_reiner = [1.0307
1.0981
1.1936
1.3047
1.4193
];
error_bode = [1.1611
1.1781
1.1954
1.2114
1.2249
];
figure('Position', [100, 100, 800, 600], 'Color', 'white');
plot(depth, error_reiner, 'LineWidth', 2.5, 'Color', [0, 0.4470, 0.7410], 'Marker', 'o', 'MarkerSize', 6, 'MarkerFaceColor', [0, 0.4470, 0.7410]);
hold on;
plot(depth, error_bode, 'LineWidth', 2.5, 'Color', [0.8500, 0.3250, 0.0980], 'Marker', 's', 'MarkerSize', 6, 'MarkerFaceColor', [0.8500, 0.3250, 0.0980]);
[~, idx_min_reiner] = min(error_reiner);
[~, idx_min_bode] = min(error_bode);
plot(depth(idx_min_reiner), error_reiner(idx_min_reiner), 'p', 'MarkerSize', 14, 'MarkerFaceColor', [0, 0.4470, 0.7410], 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
plot(depth(idx_min_bode), error_bode(idx_min_bode), 'p', 'MarkerSize', 14, 'MarkerFaceColor', [0.8500, 0.3250, 0.0980], 'MarkerEdgeColor', 'k', 'LineWidth', 1.5);
xlabel('Dipole Depth (km)', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Fitting Error (nT)', 'FontSize', 14, 'FontWeight', 'bold');
legend('Reiner Gamma Region', 'Rima Bode Region', ['Optimal Depth Reiner: ', num2str(depth(idx_min_reiner)), ' km'], ['Optimal Depth Bode: ', num2str(depth(idx_min_bode)), ' km'], 'Location', 'northeast', 'FontSize', 12);
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
grid on;
grid minor;
set(gca, 'GridAlpha', 0.3, 'MinorGridAlpha', 0.1);
all_errors = [error_reiner; error_bode]';
min_error = min(all_errors);
max_error = max(all_errors);
xlim([min(depth)-1, max(depth)+1]);
ylim([min_error - 0.05, max_error + 0.05]); 