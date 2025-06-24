img = imread('cameraman.tif');
img = im2double(img);

% Calcola la DCT dell'immagine
img_dct = dct2(img);

% Visualizza l'immagine originale
figure;
subplot(1,2,1); imshow(img, []);
title('Immagine originale');

% Visualizza la DCT (log per renderla visibile)
subplot(1,2,2); imshow(log(abs(img_dct) + 1), []);
title('DCT (visualizzata in scala logaritmica)');