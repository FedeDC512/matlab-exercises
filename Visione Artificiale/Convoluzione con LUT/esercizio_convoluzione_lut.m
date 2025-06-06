img = imread('../imgs/lena.png');
gray = rgb2gray(img);

kernel = ones(3,3) / 9;  % Filtro media

result1 = convoluzione_lut(gray, kernel);
result2 = convoluzione_lut_bordi(gray, kernel);


figure;
imshow(gray, []);
title('Immagine iniziale');

figure;
imshow(uint8(result1), []);
title('Convoluzione con Look-Up Table');

figure;
imshow(uint8(result2), []);
title('Convoluzione con Look-Up Table con Padding Replicato');
