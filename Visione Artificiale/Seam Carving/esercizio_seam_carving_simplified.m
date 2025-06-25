% Carica immagine e convertila in scala di grigi
img = imread('peppers.png');

% Numero di colonne da rimuovere
numSeams = 50;

% Riduci l'immagine con funzione built-in
img_resized = imresize(img, [size(img,1), size(img,2)-numSeams]);

figure;
imshow(img);
title('Originale');

figure;
imshow(img_resized);
title(['Ridotta di ', num2str(numSeams), ' colonne']);