%% Creazione di una "immagine" simulata
% Una matrice 5x5 con valori casuali tra 0 e 1
img = rand(5);

disp('Immagine simulata (valori random tra 0 e 1):');
disp(img);

%% Trova tutti i pixel con valore maggiore di 0.7
soglia = 0.7;
mask = img > soglia;

disp('Maschera dei pixel sopra soglia 0.7:');
disp(mask);

% Usa find() per ottenere gli indici dei pixel sopra soglia
linear_indices = find(mask);
disp('Indici lineari dei pixel sopra soglia:');
disp(linear_indices);

%% Converti da indici lineari a coordinate (riga, colonna)
[row, col] = ind2sub(size(img), linear_indices);
disp('Coordinate (riga, colonna) dei pixel sopra soglia:');
disp([row, col]);

%% Inverso: da coordinate a indice lineare (esempio)
riga = 3;
colonna = 2;
index = sub2ind(size(img), riga, colonna);
disp(['Indice lineare del pixel (3,2): ', num2str(index)]);

%% Usa randperm per creare una permutazione casuale degli indici
% Simula una modifica casuale dei pixel
nPixel = numel(img); % numel restituisce il numero degli elementi dell’array
permutazione = randperm(nPixel);

disp('Permutazione casuale degli indici dei pixel:');
disp(permutazione(1:10));  % mostra solo i primi 10

%% Trasposta della matrice immagine
img_T = img.';

disp('Trasposta della matrice immagine:');
disp(img_T);

% Confronto: pixel (2,3) in img diventa (3,2) in img_T
disp(['img(2,3) = ', num2str(img(2,3)), '  ->  img_T(3,2) = ', num2str(img_T(3,2))]);
