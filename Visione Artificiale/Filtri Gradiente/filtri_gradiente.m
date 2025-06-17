%% 1. Carica immagine e converti in float
img = imread('../imgs/barbara.png');
img = rgb2gray(img);
img = single(img); % Conversione per operazioni matematiche

%% 2. Filtro Gradiente semplice (derivata prima con convoluzione)
gx = conv2(img, [-1 1], 'same'); % Derivata in x
gy = conv2(img, [-1; 1], 'same'); % Derivata in y
grad_simple = sqrt(gx.^2 + gy.^2); % Modulo del gradiente

%% 3. Filtro di Prewitt
% Kernel Prewitt (orizzontale e verticale)
prewitt_x = fspecial('prewitt');
prewitt_y = prewitt_x';

px = conv2(img, prewitt_x, 'same');
py = conv2(img, prewitt_y, 'same');
grad_prewitt = sqrt(px.^2 + py.^2);

%% 4. Filtro di Sobel
% Kernel Sobel (più pesante sui pixel centrali)
sobel_x = fspecial('sobel');
sobel_y = sobel_x';

sx = conv2(img, sobel_x, 'same');
sy = conv2(img, sobel_y, 'same');
grad_sobel = sqrt(sx.^2 + sy.^2);

%% 5. Filtro Laplaciano (derivata seconda)
laplaciano = fspecial('laplacian', 0.2);   % coefficiente alpha = 0.2
laplace_img = conv2(img, laplaciano, 'same');

%% 6. Visualizzazione dei risultati
figure;
imshow(uint8(img));
title('Immagine originale');

figure;
imshow(grad_simple, []);
title('Gradiente semplice');

figure;
imshow(grad_prewitt, []);
title('Prewitt (1a derivata)');

figure;
imshow(grad_sobel, []);
title('Sobel (1a derivata + media)');

figure;
imshow(laplace_img, []);
title('Laplaciano (2a derivata)');

figure;
imshow(abs(laplace_img), []);
title('|Laplaciano| (valori assoluti)');
