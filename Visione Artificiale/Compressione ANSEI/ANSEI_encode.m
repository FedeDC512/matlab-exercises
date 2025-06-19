function compressed = ANSEI_encode(img, numColors)
    % Codifica ANSEI base
    % img: immagine RGB (uint8)
    % numColors: numero di colori nella palette (es. 16)
    
    img = im2double(img);  % Normalizza tra 0 e 1
    [ind, map] = rgb2ind(img, numColors);  % Quantizzazione
    [H, W] = size(ind);
    N = H * W;

    CTRL = zeros(N, 1, 'uint8');   % Codici di controllo: 0-3
    DATA = zeros(N, 1);           % Dato (indice o componente)
    
    % Primo pixel
    idx1 = ind(1, 1);
    RGB_prev = map(idx1 + 1, :);  % +1 perché gli indici sono 0-based
    CTRL(1) = 0;
    DATA(1) = idx1;
    
    % Codifica pixel per pixel
    count = 1;
    for y = 1:H
        for x = 1:W
            if y == 1 && x == 1, continue; end  % Primo già trattato
            
            count = count + 1;
            idx_curr = ind(y, x);
            RGB_curr_palette = map(idx_curr + 1, :);
            RGB_orig = squeeze(img(y, x, :))';

            % Candidati
            c0 = RGB_curr_palette;
            c1 = [RGB_curr_palette(1), RGB_prev(2:3)];
            c2 = [RGB_prev(1), RGB_curr_palette(2), RGB_prev(3)];
            c3 = [RGB_prev(1:2), RGB_curr_palette(3)];

            % Distanze
            d = [
                norm(RGB_orig - c0), ...
                norm(RGB_orig - c1), ...
                norm(RGB_orig - c2), ...
                norm(RGB_orig - c3)
            ];

            [~, minK] = min(d); % Selezione scelta migliore (1-based)
            CTRL(count) = minK - 1;  % Salva codice di controllo

            switch minK
                case 1  % CTRL = 0
                    DATA(count) = idx_curr;
                    RGB_prev = c0;
                case 2  % CTRL = 1
                    DATA(count) = RGB_curr_palette(1);
                    RGB_prev = c1;
                case 3  % CTRL = 2
                    DATA(count) = RGB_curr_palette(2);
                    RGB_prev = c2;
                case 4  % CTRL = 3
                    DATA(count) = RGB_curr_palette(3);
                    RGB_prev = c3;
            end
        end
    end

    % Output: struttura compressa
    compressed.CTRL = CTRL;
    compressed.DATA = DATA;
    compressed.map = map;
    compressed.H = H;
    compressed.W = W;
end