function [] = main_gongetidu_3D_2_optimized()
    clear; clc; close all;
    fpath1 = 'D:\';
    G = [];
    for kk = 1:3
        switch kk
            case 1
                fpath = [fpath1, 'model\matrix_R\x\'];
            case 2
                fpath = [fpath1, 'model\matrix_R\y\'];
            case 3
                fpath = [fpath1, 'model\matrix_R\z\'];
        end
        load([fpath1, 'model\matrix_R\b'], 'b');
        load([fpath, 'Gx'], 'Gx');
        load([fpath, 'Gy'], 'Gy');
        load([fpath, 'Gz'], 'Gz');
        G1 = [Gx, Gy, Gz];
        G = [G; G1];
    end
    [n_obs, n_params] = size(G);
    Q0 = G' * G;
    lambda = 10^-21.25;    
    Q = Q0 + lambda * eye(n_params);
    B = G' * b;
    X0 = ones(n_params, 1) * 1e0;  
    max_iter = 500;
    tol = 1e-6;
    xk = X0;
    rk = B - Q * xk;
    dk = rk;
    s = zeros(max_iter, 1);
    for k = 1:max_iter
        alpha = (rk' * rk) / (dk' * Q * dk);
        xk_new = xk + alpha * dk;
        rk_new = B - Q * xk_new;
        residual = b - G * xk_new;
        s(k) = sqrt(residual' * residual / n_obs);
        beta = (rk_new' * rk_new) / (rk' * rk);
        dk = rk_new + beta * dk;
        xk = xk_new;
        rk = rk_new;
        if k > 1
            rel_change = abs(s(k) - s(k-1)) / s(k-1);
            fprintf('Iteration %d: RMS error = %.6f, Rel.change = %.6e\n', k, s(k), rel_change);
            if rel_change < tol || s(k) < tol
                fprintf('Converged after %d iterations\n', k);
                break;
            end
        end
    end
    s = s(1:k);
    Xk_fixed = xk;
    save([fpath1, 'model\matrix_R\Xk_fixed.mat'], 'Xk_fixed');
    save([fpath1, 'model\matrix_R\s_fixed.mat'], 's');
    figure;
    scatter(1:k, s, 80, '.');
    hold on;
    plot(1:k, s, 'LineWidth', 1.2);
    hold off;
    xlabel('Iteration count k', 'FontSize', 14);
    ylabel('RMS σ/nT', 'FontSize', 14);
    grid on;
end