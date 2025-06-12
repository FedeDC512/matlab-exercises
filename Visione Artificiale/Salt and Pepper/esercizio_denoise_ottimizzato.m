img = imread('../imgs/lena.png');
img_gray = rgb2gray(img);

% Aggiunge rumore salt & pepper (es. 5% dei pixel)
img_noisy = imnoise(img_gray, 'salt & pepper', 0.05);

% Trova i pixel rumorosi: 0 = pepe, 255 = sale
b = find(img_noisy == 255);  % Indici pixel bianchi
n = find(img_noisy == 0);    % Indici pixel neri

% Applica filtro mediana all'intera immagine (per recuperare pixel puliti)
img_median = medfilt2(img_noisy, [3 3]);
% Crea una copia dell'immagine rumorosa
img_fixed = img_noisy;
% Sostituisci solo i pixel rumorosi con quelli filtrati
img_fixed(b) = img_median(b);
img_fixed(n) = img_median(n);

% Visualizzazione
figure;
imshow(img_gray);
title('Immagine originale');

figure;
imshow(img_noisy);
title('Con rumore Salt & Pepper');

figure;
imshow(img_fixed);
title('Denoise ottimizzato (solo su pixel rumorosi)');