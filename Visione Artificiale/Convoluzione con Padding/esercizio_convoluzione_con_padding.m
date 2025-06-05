img = imread('../imgs/lena.png');

img_gray = rgb2gray(img);

% Definizione del kernel
kernel = ones(3,3) / 9; % Filtro Media

% Chiamata alla funzione
result = convoluzione_con_padding(img_gray, kernel, 'replicate'); % Duplica i bordi
imshow(result);

% Visualizzazione
figure;
imshow(img_gray, []);
title('Immagine iniziale');

figure;
imshow(result, []);
title('Risultato della convoluzione con padding');