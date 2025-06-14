img1 = imread('../imgs/barbara.png');
img1 = rgb2gray(img1);
img2 = imread('../imgs/peppers.png');
img2 = rgb2gray(img2);

% Ridimensiona img2 per abbinarla a img1 (se necessario)
img2 = imresize(img2, size(img1));

% Blend: fusione pesata
a = 0.7;
blended = uint8(a * single(img1) + (1 - a) * single(img2));

% Visualizzazione
figure;
imshow(img1);
title('Immagine 1');

figure;
imshow(img2);
title('Immagine 2');

figure;
imshow(blended);
title(['Blend: ', num2str(a), ' * img1 + ', num2str(1-a), ' * img2']);