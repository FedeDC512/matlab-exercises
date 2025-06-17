% Caricamento immagine TrueColor
img = imread('../imgs/peppers.png');  % Immagine RGB standard
img_double = im2double(img);  % Converte in double per evitare problemi con rgb2ind

figure;
imshow(img);
title('Immagine Originale (TrueColor)');

% Quantizzazione a 16 colori
nColors = 16;
[ind16, map16] = rgb2ind(img_double, nColors);

figure;
imshow(ind16, map16);
title('Immagine Indicizzata (16 Colori)');

% Quantizzazione a 256 colori
nColors = 256;
[ind256, map256] = rgb2ind(img_double, nColors);

figure;
imshow(ind256, map256);
title('Immagine Indicizzata (256 Colori)');

% Conversione inversa (da indicizzata a RGB)
img_rgb_from_ind = ind2rgb(ind16, map16);  % Back to RGB

figure;
imshow(img_rgb_from_ind);
title('Ricostruzione RGB da Indicizzata');