function img_out = seam_carving(img_in, n_cols)
% Riduce la larghezza di un'immagine di n_cols colonne usando seam carving.
% img_in: immagine input (RGB o grayscale)
% n_cols: numero di colonne da rimuovere

img = im2double(img_in);
for k = 1:n_cols
    if size(img, 3) == 3
        gray = rgb2gray(img);
    else
        gray = img;
    end

    % Calcola energia come modulo del gradiente
    [gx, gy] = gradient(gray);
    energy = abs(gx) + abs(gy);

    % Programmazione dinamica per mappa energia cumulativa
    [h, w] = size(energy);
    M = energy;
    backtrack = zeros(h, w);

    for i = 2:h
        for j = 1:w
            if j == 1
                [val, idx] = min([M(i-1,j), M(i-1,j+1)]);
                backtrack(i,j) = j - 1 + idx;
            elseif j == w
                [val, idx] = min([M(i-1,j-1), M(i-1,j)]);
                backtrack(i,j) = j - 2 + idx;
            else
                [val, idx] = min([M(i-1,j-1), M(i-1,j), M(i-1,j+1)]);
                backtrack(i,j) = j - 2 + idx;
            end
            M(i,j) = M(i,j) + val;
        end
    end

    % Trova seam minimo
    seam = zeros(h,1);
    [~, seam(h)] = min(M(h,:));
    for i = h-1:-1:1
        seam(i) = backtrack(i+1, seam(i+1));
    end

    % Rimuovi seam
    for i = 1:h
        img(i, seam(i):end-1, :) = img(i, seam(i)+1:end, :);
    end
    img = img(:,1:end-1,:);
end

img_out = img;
end
