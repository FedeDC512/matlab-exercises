img = rgb2gray(imread('../imgs/lena.png'));

% Definizione di vari filtri fspecial
filters = {
    'Gaussian 5x5, sigma=1', fspecial('gaussian', [5 5], 1);
    'Motion blur length=10, angle=45', fspecial('motion', 10, 45);
    'Average 3x3', fspecial('average', [3 3]);
    'Laplacian alpha=0.2', fspecial('laplacian', 0.2);
    'Prewitt horizontal', fspecial('prewitt');
    'Sobel horizontal', fspecial('sobel');
    'Disk radius=5', fspecial('disk', 5)
};

% Ciclo per applicare i filtri, mostrare e titolare immagini
for i = 1:size(filters, 1)
    titleText = filters{i, 1};
    kernel = filters{i, 2};

    % Applica filtro con conv2, mantenendo dimensione immagine originale
    filteredImg = conv2(img, kernel, 'same');

    % Visualizza immagine filtrata
    figure;
    imshow(filteredImg, []);
    title(['Filtro: ', titleText]);
end