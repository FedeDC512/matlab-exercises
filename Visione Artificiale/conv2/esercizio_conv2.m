img = imread('../imgs/lena.png');
img_gray = rgb2gray(img);

% kernel = fspecial('gaussian', [3,3], 1); % Kernel Gaussiano 3x3
kernel = ones(3,3) / 9; % Kernel Media
filtered_img = conv2(single(img_gray), kernel, 'valid');
imshow(uint8(filtered_img));

conv_full = conv2(single(img_gray), kernel, 'full'); % Restituisce tutta la convoluzione (includendo il bordo extra)
conv_same = conv2(single(img_gray), kernel, 'same'); % Mantiene le dimensioni originali
conv_valid = conv2(single(img_gray), kernel, 'valid'); % Restituisce solo le parti senza padding (l'immagine risultante è più piccola)

figure;
imshow(img_gray);
title('Immagine iniziale');

figure;
imshow(uint8(conv_full));
title('Convoluzione "full": include anche i bordi esterni (immagine più grande)');

figure;
imshow(uint8(conv_same));
title('Convoluzione "same": mantiene le dimensioni originali');

figure;
imshow(uint8(conv_valid));
title('Convoluzione "valid": solo pixel completamente interni (immagine più piccola)');