img = imread('peppers.png');  % Immagine RGB

% Compressione
compressed = ANSEI_encode(img, 16);

% Decompressione
img_rec = ANSEI_decode(compressed);

% Visualizzazione
figure;
imshow(img);
title('Originale');

figure;
imshow(img_rec);
title('Ricostruita con ANSEI');
