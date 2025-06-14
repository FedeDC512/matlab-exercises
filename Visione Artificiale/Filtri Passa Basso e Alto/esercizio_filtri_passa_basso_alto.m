img = imread('../imgs/barbara.png');
img = rgb2gray(img);

% Convoluzione con filtro passa basso (media 3x3)
filtro_media = fspecial('average', [3 3]);
img_basso = conv2(single(img), filtro_media, 'same');

% Filtro passa alto = originale - bassa frequenza
img_alto = single(img) - img_basso;

% Aumenta i dettagli (originale + passa alto)
img_dettagli = single(img) + img_alto; % Aumenta i dettagli

% Aumenta il rumore (accentua le alte frequenze)
img_rumorosa = single(img) + 2 * img_alto; % Aumenta il rumore

% Visualizzazione
figure;
imshow(img);
title('Immagine originale');

figure;
imshow(uint8(img_basso));
title('Filtro passa basso (sfocatura)');

figure;
imshow(img_alto, []);
title('Filtro passa alto (dettagli)');

figure;
imshow(uint8(img_dettagli));
title('Originale + Filtro passa alto');

figure;
imshow(uint8(img_rumorosa));
title('Originale + 2 * Filtro passa alto');
