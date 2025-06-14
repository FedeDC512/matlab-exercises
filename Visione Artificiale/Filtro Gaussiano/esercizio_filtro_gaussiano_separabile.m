img = imread('../imgs/barbara.png');
img_gray = rgb2gray(img);

% Applica un filtro gaussiano sfruttando la separabilità (2 passaggi 1D)
% Crea un filtro gaussiano 1D (orizzontale)
h = fspecial('gaussian', [1 5], 1);  % Kernel 1D, 5 elementi, sigma = 1

% Primo passaggio: convoluzione orizzontale
img_temp = conv2(img_gray, h, 'same');

% Secondo passaggio: convoluzione verticale (trasposto del kernel)
img_filtered = conv2(img_temp, h', 'same');

% Visualizzazione
figure;
imshow(uint8(img_gray));
title('Immagine originale');

figure;
imshow(uint8(img_filtered));
title('Filtro Gaussiano separabile');