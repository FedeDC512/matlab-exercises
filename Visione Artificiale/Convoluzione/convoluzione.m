function output = convoluzione(img, k)
    % Converte l'immagine in single precision per il calcolo
    img = single(img);

    % Ottiene le dimensioni dell'immagine e del kernel
    [h, w] = size(img);
    [kh, kw] = size(k);

    % Calcola gli offset per il centro del kernel
    a = floor(kh / 2);
    b = floor(kw / 2);

    % Inizializza la nuova immagine con zeri (stessa dimensione dell'originale)
    temp = zeros(h, w, 'single');

    % Scansiona l'immagine ignorando i bordi
    for j = 1 + a : h - a
        for i = 1 + b : w - b
            temp = 0; % Accumulatore del valore convoluto

            % Applica il kernel con doppio for
            for x = -a : a
                for y = -b : b
                    temp = temp + img(j - y, i - x) * k(y + a + 1, x + b + 1);
                end
            end

            % Assegna il valore convoluto alla nuova immagine
            output(j, i) = temp;
        end
    end

    % Converte il risultato finale in uint8 per la visualizzazione
    output = uint8(output);
end
