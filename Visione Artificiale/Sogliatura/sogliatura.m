%% Caricamento immagine in scala di grigi
img = imread('cameraman.tif');  % Immagine di esempio standard in MATLAB
img = im2uint8(img);            % Assicura formato uint8

figure;
imshow(img);
title('Immagine originale (grayscale)');

%% Sogliatura con soglia fissa
thresh_fixed = 100;
bw_fixed = img > thresh_fixed;

figure;
imshow(bw_fixed);
title(['Sogliatura con soglia fissa = ', num2str(thresh_fixed)]);

%% Sogliatura con valore medio
thresh_mean = mean(img(:));
bw_mean = img > thresh_mean;

figure;
imshow(bw_mean);
title(['Sogliatura con soglia = media (' num2str(round(thresh_mean)) ')']);

%% Sogliatura con valore mediano
thresh_median = median(double(img(:)));
bw_median = img > thresh_median;

figure;
imshow(bw_median);
title(['Sogliatura con soglia = mediana (' num2str(round(thresh_median)) ')']);

%% Sogliatura con metodo di Otsu (automatica)
level = graythresh(img);       % Calcola soglia normalizzata in [0,1]
thresh_otsu = level * 255;     % La converto per visualizzare
bw_otsu = imbinarize(img, level);

figure;
imshow(bw_otsu);
title(['Sogliatura con metodo di Otsu (soglia = ', num2str(round(thresh_otsu)), ')']);

%% Istogramma con soglie visualizzate
figure;
imhist(img); hold on;
xline(thresh_fixed, 'r', 'LineWidth', 1.5);
xline(thresh_mean, 'g', 'LineWidth', 1.5);
xline(thresh_median, 'b', 'LineWidth', 1.5);
xline(thresh_otsu, 'k--', 'LineWidth', 2);
legend('Istogramma', 'Fisso', 'Media', 'Mediana', 'Otsu');
title('Istogramma con soglie evidenziate');
