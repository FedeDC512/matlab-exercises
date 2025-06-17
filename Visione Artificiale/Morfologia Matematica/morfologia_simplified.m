clear;
close all;
clc;

img = imread('cameraman.tif');
se = strel('disk', 5); % Elemento strutturante standard

% Applica le funzioni native di MATLAB
img_erosa    = imerode(img, se);
img_dilatata = imdilate(img, se);
img_aperta   = imopen(img, se);
img_chiusa   = imclose(img, se);
gradiente    = imdilate(img, se) - imerode(img, se);
top_hat      = imtophat(img, se);
bottom_hat   = imbothat(img, se);

figure('Name', 'Morfologia con Funzioni MATLAB', 'WindowState', 'maximized');
tiledlayout(2, 4, 'Padding', 'compact'); % Layout compatto per le immagini

nexttile; imshow(img);          title('Originale');
nexttile; imshow(img_erosa);    title('Erosione');
nexttile; imshow(img_dilatata); title('Dilatazione');
nexttile; imshow(gradiente);    title('Gradiente');
nexttile; imshow(img_aperta);   title('Apertura');
nexttile; imshow(img_chiusa);   title('Chiusura');
nexttile; imshow(top_hat);      title('Top-Hat');
nexttile; imshow(bottom_hat);   title('Bottom-Hat');