img = imread('cameraman.tif');
img = im2double(img); % Conversione in double

% Applica la DWT di livello 1 con la wavelet di Haar
[CA, CH, CV, CD] = dwt2(img, 'haar');

% Visualizza i risultati
figure('Name', 'Trasformata Wavelet di Haar (1 livello)');
subplot(2,2,1); imshow(CA, []); title('Approssimazioni (LL)');
subplot(2,2,2); imshow(CH, []); title('Dettagli Orizzontali (LH)');
subplot(2,2,3); imshow(CV, []); title('Dettagli Verticali (HL)');
subplot(2,2,4); imshow(CD, []); title('Dettagli Diagonali (HH)');