% Dependencies:
%   - Psychtoolbox
%   - SilentSubstitutionToolbox

%% === SPECTRAL SENSITIVITIES ===
% Load the CIE S026 spectral sensitivities
[T_cies026, S] = GetCIES026
wls_cies026 = SToWls(S);

% Plot the spectra
subplot(5, 1, 1);
rgb = SSTDefaultReceptorColors({'SCone', 'MCone', 'LCone', 'Rod', 'Mel'});
for ii = 1:5
    plot(wls_cies026, T_cies026(ii, :), 'Color', rgb(ii, :), 'LineWidth', 3); hold on;
end
pbaspect([1 0.5 1]);

% Add graphical elements
set(gca, 'TickDir', 'out');
xlim([380 780]);
ylim([0 1.02]);
%xlabel('Wavelength [nm]');
ylabel('Normalised sensitivity');
title('(A) Spectral sensitivities');
box off;

%% === SPECTRA ===
% Load the Houser et al. spectra
load spd_houser
for ii = 1:length(spd_houser)
    cct(ii) = SPDToCCT(spd_houser(:, ii), S_houser);
end
wls_houser = SToWls(S_houser);
spd_houser(spd_houser == 0) = eps;

%% Indices near 5000K
x = find((cct > 4900) & (cct < 5100));
% for ii = 1:length(x); plot(spd_houser(:, x(ii))); pause; end % Identify
% candidate spectra

%   132 % Daylight
%   39 % CIE F8
%   246 % LED
%   2 % 4-LED Model

subplot(5, 1, 2);
area(wls_houser, spd_houser(:, 132), 'LineWidth', 3)
set(gca, 'TickDir', 'out');
xlim([380 780]);
ylim([0 1.02]);
%xlabel('Wavelength [nm]');
ylabel('Normalised radiance');
pbaspect([1 0.5 1]);
title('(B) Daylight');
box off;

subplot(5, 1, 3);
area(wls_houser, spd_houser(:, 39), 'LineWidth', 3)
set(gca, 'TickDir', 'out');
xlim([380 780]);
ylim([0 1.02]);
%xlabel('Wavelength [nm]');
ylabel('Normalised radiance');
pbaspect([1 0.5 1]);
title('(C) Fluorescent');
box off;

subplot(5, 1, 4);
area(wls_houser, spd_houser(:, 246), 'LineWidth', 3)
set(gca, 'TickDir', 'out');
xlim([380 780]);
ylim([0 1.02]);
%xlabel('Wavelength [nm]');
ylabel('Normalised radiance');
pbaspect([1 0.5 1]);
title('(D) LED');
box off;

subplot(5, 1, 5);
area(wls_houser, spd_houser(:, 2), 'LineWidth', 3)
set(gca, 'TickDir', 'out');
xlim([380 780]);
ylim([0 1.02]);
xlabel('Wavelength [nm]');
ylabel('Normalised radiance');
pbaspect([1 0.5 1]);
title('(E) 4-LED mixture');
box off;

% Save out the plot
set(gcf, 'PaperPosition', [0 0 8 25]);
set(gcf, 'PaperSize', [8 25]);
saveas(gcf, 'figure_raw.pdf', 'pdf')

% For editing in illustrator
% Wavelengths
% Violet	400 nm % 5%
% Indigo	425 nm % 11.25%
% Blue      470 nm % 22.5%
% Green     550 nm % 42.5%
% Yellow	600 nm % 55%
% Orange	630 nm % 62.5%
% Red       665 nm % 71.25%

% Save out the spectra
csvwrite('spectra.csv', [wls_houser spd_houser(:, 132) spd_houser(:, 39) spd_houser(:, 246) spd_houser(:, 2)])