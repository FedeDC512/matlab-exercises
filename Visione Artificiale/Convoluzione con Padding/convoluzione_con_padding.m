function output = convoluzione_con_padding(img, k, padding_type)
    [h, w] = size(img);    % Dimensioni immagine originale
    [kh, kw] = size(k);    % Dimensioni del kernel
    
    a = floor(kh / 2);     % Offset verticale
    b = floor(kw / 2);     % Offset orizzontale
    
    % Inserisce il padding specificato (replicate, symmetric, circular, ecc.)
    padded_img = padarray(img, [a, b], padding_type);
    
    output = zeros(h, w, 'single');  % Matrice per l'output

    % Loop sulla versione originale dell'immagine
    for j = 1:h
        for i = 1:w
            temp = 0;
            for x = -a:a
                for y = -b:b
                    % Accede alla versione paddata con un offset
                    temp = temp + padded_img(j + a - y, i + b - x) * k(y + a + 1, x + b + 1);
                end
            end
            output(j, i) = temp;
        end
    end
    
    output = uint8(output); % Conversione a immagine
end
