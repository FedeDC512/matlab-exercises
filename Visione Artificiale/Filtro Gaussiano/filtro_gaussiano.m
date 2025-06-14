img = imread('../imgs/barbara.png');
img = rgb2gray(img);

% Crea un kernel gaussiano 5x5 con deviazione standard 1
h = fspecial('gaussian', [5 5], 1);

% Applicazione del filtro tramite convoluzione
img_filtered = conv2(double(img), h, 'same');

% Visualizzazione dei risultati
figure;
imshow(img);
title('Immagine originale');

figure;
imshow(uint8(img_filtered));
title('Filtro Gaussiano 5x5 (\sigma = 1)');
