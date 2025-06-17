%% 1. Carica immagine e convertila in scala di grigi
img_rgb = imread('../imgs/peppers.png');
img_gray = rgb2gray(img_rgb);

% Visualizzazione immagine originale
figure; imshow(img_gray);
title('Immagine in scala di grigi');

%% 2. Istogramma di luminosità (vettore numerico)
H = imhist(img_gray, 256); % Vettore di frequenze (1x256)

% Verifica proprietà fondamentale: somma = numero pixel
assert(sum(H) == numel(img_gray), 'Errore: somma istogramma ≠ numero pixel');

% Visualizzazione personalizzata
plothist(img_gray);
plothist_outlier(img_gray);

% Genera immagine grigia casuale
img_test = uint8(randi([0, 255], 200, 200));  
% Aggiungi outlier forzando molti pixel a valore 50 (picco anomalo)
img_test(1:1000) = 50; 

% Visualizza immagine test
figure; imshow(img_test);
title('Immagine test con picco-outlier');

% Confronto grafico dei due istogrammi (semplice vs outlier)
plothist(img_test);
plothist_outlier(img_test);

%% 3. Istogrammi separati dei canali RGB
R = img_rgb(:,:,1);
G = img_rgb(:,:,2);
B = img_rgb(:,:,3);

HR = imhist(R, 256);
HG = imhist(G, 256);
HB = imhist(B, 256);

% Plot RGB insieme (con gestione outlier)
figure;
hold on;
plot(0:255, HR, 'r');
plot(0:255, HG, 'g');
plot(0:255, HB, 'b');
legend('Rosso','Verde','Blu');
title('Istogrammi RGB');
xlabel('Livello di intensità');
ylabel('Numero di pixel');
grid on;

%% 4. Istogramma ridotto (16 bin)
n_bin = 16;
H_short = zeros(1, n_bin);
for i = 1:n_bin
    idx = (i-1)*16 + 1 : i*16;
    H_short(i) = sum(H(idx));
end

% Visualizzazione istogramma ridotto
figure;
bar(0:n_bin-1, H_short, 'k');
title('Istogramma ridotto a 16 bin');
xlabel('Bin');
ylabel('Conteggio');

%% 5. Confronto immagini con stesso istogramma
img_scrambled = img_gray(randperm(end));

% Verifica: stesso istogramma
H_scrambled = imhist(reshape(img_scrambled, size(img_gray)), 256);
assert(isequal(H, H_scrambled), 'Istogramma NON identico');

% Visualizzazione immagini
figure;
subplot(1,2,1); imshow(img_gray); title('Originale');
subplot(1,2,2); imshow(reshape(img_scrambled, size(img_gray))); title('Pixel rimescolati');

%% 6. Istogrammi per quadranti
[m, n] = size(img_gray);
Q1 = img_gray(1:floor(m/2), 1:floor(n/2));
Q2 = img_gray(1:floor(m/2), floor(n/2)+1:end);
Q3 = img_gray(floor(m/2)+1:end, 1:floor(n/2));
Q4 = img_gray(floor(m/2)+1:end, floor(n/2)+1:end);

figure;
subplot(2,2,1); plot(imhist(Q1)); title('Quadrante 1');
subplot(2,2,2); plot(imhist(Q2)); title('Quadrante 2');
subplot(2,2,3); plot(imhist(Q3)); title('Quadrante 3');
subplot(2,2,4); plot(imhist(Q4)); title('Quadrante 4');

% Questa firma (Q1–Q4) permette di distinguere immagini rimescolate

