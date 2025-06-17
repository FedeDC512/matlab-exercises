function h = plothist_outlier(img)
    % Funzione per visualizzare un istogramma con barra di grigio e gestione outlier

    if ~isa(img, 'uint8')
        img = uint8(img);
    end

    h = imhist(img, 256); % Istogramma
    out = uint8(ones(120, 256) * 255); % Immagine bianca

    %% 1. Rilevamento outlier (bin > soglia, es. 3× mediana)
    soglia = 3 * median(h);
    outlier_mask = h > soglia;
    h_clean = h;
    h_clean(outlier_mask) = soglia; % Limita outlier per la normalizzazione

    %% 2. Calcolo altezza delle barre normalizzate
    m = 101 - ceil(100 * single(h_clean) / single(max(h_clean)));

    %% 3. Disegna le barre dell'istogramma
    for i = 1:256
        out(m(i):100, i) = 0; % Barre nere

        % Se è outlier, disegna un indicatore (puntino nero sulla riga 101)
        if outlier_mask(i)
            out(101, i) = 0; % Riga di separazione usata come marker
        end
    end

    %% 4. Disegna la barra del gradiente grigio
    for i = 1:256
        out(102:120, i) = i - 1;
    end

    %% 5. Visualizza
    figure;
    imshow(out);
    title('Istogramma con funzione personalizzata e outlier gestiti');
end
