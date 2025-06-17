img_rgb = imread('../imgs/peppers.png');
img_gray = rgb2gray(img_rgb);

% Mostra immagine originale
figure;
imshow(img_gray);
title('Immagine in scala di grigi');

figure;
imshow(img_rgb);
title('Immagine a colori');

% Calcola e visualizza istogramma con funzione standard
figure;
imhist(img_gray);
title('Istogramma (con imhist)');

% Istogramma RGB (canali separati)
R = img_rgb(:,:,1);
G = img_rgb(:,:,2);
B = img_rgb(:,:,3);

figure;
hold on;
plot(imhist(R), 'r');
plot(imhist(G), 'g');
plot(imhist(B), 'b');
title('Istogrammi dei canali RGB');
xlabel('Livelli di intensità');
ylabel('Frequenza');
legend('Rosso','Verde','Blu');
