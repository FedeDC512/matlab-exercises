img = imread('cameraman.tif');
img = im2double(img);

% Decomposizione Wavelet (3 livelli) con Haar
nLivelli = 3;
[coeffs, sizes] = wavedec2(img, nLivelli, 'haar');

% Estrai componenti a ciascun livello
A3 = appcoef2(coeffs, sizes, 'haar', 3); % Approssimazioni livello 3
[H3, V3, D3] = detcoef2('all', coeffs, sizes, 3);
[H2, V2, D2] = detcoef2('all', coeffs, sizes, 2);
[H1, V1, D1] = detcoef2('all', coeffs, sizes, 1);

% Mostra risultati
figure('Name', 'Analisi Multirisoluzione - Haar');
subplot(3,4,1); imshow(A3, []); title('A3 (appross.)');
subplot(3,4,2); imshow(H3, []); title('H3');
subplot(3,4,3); imshow(V3, []); title('V3');
subplot(3,4,4); imshow(D3, []); title('D3');

subplot(3,4,6); imshow(H2, []); title('H2');
subplot(3,4,7); imshow(V2, []); title('V2');
subplot(3,4,8); imshow(D2, []); title('D2');

subplot(3,4,10); imshow(H1, []); title('H1');
subplot(3,4,11); imshow(V1, []); title('V1');
subplot(3,4,12); imshow(D1, []); title('D1');