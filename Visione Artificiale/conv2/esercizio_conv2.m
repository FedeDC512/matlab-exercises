img = imread('../imgs/lena.png');
img_gray = rgb2gray(img);

kernel = fspecial('gaussian', [3,3], 1); % Kernel Gaussiano 3x3
filtered_img = conv2(single(img_gray), kernel, 'same');
imshow(uint8(filtered_img));

conv_full = conv2(single(img_gray), kernel, 'full'); % Restituisce tutta la convoluzione (includendo il bordo extra)
conv_same = conv2(single(img_gray), kernel, 'same'); % Mantiene le dimensioni originali
conv_valid = conv2(single(img_gray), kernel, 'valid'); % Restituisce solo le parti senza padding (l'immagine risultante è più piccola)