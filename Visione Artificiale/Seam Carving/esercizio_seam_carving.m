img = imread('../imgs/peppers.png'); % Immagine RGB
n = 50; % Numero di colonne da rimuovere

img_out = seam_carving(img, n);

% Visualizzazione
figure;
imshow(img);
title('Originale');

figure;
imshow(img_out);
title(['Dopo Seam Carving (rimosse ', num2str(n), ' colonne)']);
