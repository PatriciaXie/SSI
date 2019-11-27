ssi = load( ssiPath );

figure(1)
plot(ssi.SSI, 'g', 'LineWidth', 1);
hold on
plot(ssi.SSI_f, 'k', 'LineWidth', 2);
hold off
grid on
legend('SSI Original', 'SSI Smoothed');
xlabel('time (s)');
ylabel('SSI');