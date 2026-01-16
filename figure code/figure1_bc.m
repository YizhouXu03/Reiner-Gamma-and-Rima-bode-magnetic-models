subplot(1,2,1)
h1 = [0 10 20 30 40 50 60 70 80 90 100];
b1 = [55.24 26.48 13.23 7.11 4.11 2.52 1.63 1.10 0.77 0.56 0.42];
h2 = [0 10 20 30 40 50 60 70 80 90 100];
b2 = [158.22 55.47 23.90 12.10 6.87 4.24 2.78 1.91 1.36 1.00 0.75];
plot(b1,h1,'-ob','LineWidth',1.5,'MarkerSize',5,'DisplayName','T15 model'); hold on
plot(b2,h2,'-sr','LineWidth',1.5,'MarkerSize',5,'DisplayName','R20 model');
xlabel('Bt (nT)','FontSize',14)
ylabel('Height (km)','FontSize',14)
title('(b) Reiner Gamma', 'FontSize',15, 'FontWeight','bold', ...
      'Position', [0, 102], 'HorizontalAlignment', 'left');
set(gca,'FontSize',13,'LineWidth',1.2)
set(gca,'YDir','normal')
grid on
legend('Location','northeast','FontSize',12,'Box','off')
text(45, 50, 'Reiner Gamma (7.5°N, 302.5°E)', 'FontSize', 12, ...
     'HorizontalAlignment', 'left', 'Color', 'k', 'FontWeight', 'normal');
subplot(1,2,2)
in4 = readtable('heightlocationt15.txt');
br4 = table2array(in4(:,1));
bt4 = table2array(in4(:,2));
bp4 = table2array(in4(:,3));
b4 = sqrt(br4.^2+bt4.^2+bp4.^2);
h4 = [0 10 25 30 40 50 60 70 80 90 100];
in5 = readtable('heightlocationr20.txt');
br5 = table2array(in5(:,1));
bt5 = table2array(in5(:,2));
bp5 = table2array(in5(:,3));
b5 = sqrt(br5.^2+bt5.^2+bp5.^2);
h5 = [0 10 20 30 40 50 60 70 80 90 100];
plot(b4,h4,'-ob','LineWidth',1.5,'MarkerSize',5,'DisplayName','T15 model'); hold on
plot(b5,h5,'-sr','LineWidth',1.5,'MarkerSize',5,'DisplayName','R20 model');
xlabel('Bt (nT)','FontSize',14)
ylabel('Height (km)','FontSize',14)
title('(c) Rima Bode', 'FontSize',15, 'FontWeight','bold', ...
      'Position', [0, 102], 'HorizontalAlignment', 'left');
set(gca,'FontSize',13,'LineWidth',1.2)
set(gca,'YDir','normal')
grid on
legend('Location','northeast','FontSize',12,'Box','off')
text(1, 50, 'Rima Bode (12.5°N, 357.5°E)', 'FontSize', 12, ...
     'HorizontalAlignment', 'left', 'Color', 'k', 'FontWeight', 'normal');
set(gcf,'Position',[100 100 1000 450])