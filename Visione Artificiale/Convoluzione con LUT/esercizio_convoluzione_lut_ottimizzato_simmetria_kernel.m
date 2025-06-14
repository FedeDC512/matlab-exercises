img = imread('../imgs/lena.png');
img_gray = rgb2gray(img);

[h, w] = size(img_gray);
I = img_gray(:);  % Linearizzazione immagine

% Kernel medio (tutti i coefficienti uguali)
kernel = fspecial('average', [3 3]); % 3x3 media
[kh, kw] = size(kernel);
kernel_values = kernel(:); % LUT dei pesi del kernel

% LUT delle posizioni relative rispetto al centro
offsets = [];
for rowShift = -floor(kh/2):floor(kh/2)
    for colShift = -floor(kw/2):floor(kw/2)
        offsets(end+1) = rowShift * w + colShift;
    end
end

% Preallocazione immagine di output
I_new = zeros(h * w, 1);

% Convoluzione ottimizzata:
% Poiché il kernel è simmetrico (tutti valori = 1/9), si può fare una somma e poi moltiplicare una volta sola

for row = 2:h-1 % Ignora i bordi (per semplicità)
    for col = 2:w-1
        i = (row - 1) * w + col; % Indice lineare del pixel centrale

        % Somma dei pixel nell'intorno
        local_sum = sum(I(i + offsets));

        % Media (evita 9 moltiplicazioni per 1/9)
        I_new(i) = local_sum / numel(kernel_values);
    end
end

% Ricostruzione dell'immagine finale
img_filtered = reshape(I_new, h, w);

% Visualizzazione
figure;
imshow(uint8(img_gray));
title('Immagine originale');

figure;
imshow(uint8(img_filtered));
title('Convoluzione ottimizzata (simmetria kernel)');
