function outputImage = convoluzione_lut_bordi(inputImage, kernel)

    [imageHeight, imageWidth] = size(inputImage);
    [kernelHeight, kernelWidth] = size(kernel);

    padH = floor(kernelHeight / 2);
    padW = floor(kernelWidth / 2);

    % Creazione immagine padded con padding replicato
    paddedImage = zeros(imageHeight + 2*padH, imageWidth + 2*padW, 'single');

    % Posiziona immagine originale al centro
    paddedImage(padH+1:padH+imageHeight, padW+1:padW+imageWidth) = single(inputImage);

    % Pad righe superiori
    paddedImage(1:padH, padW+1:padW+imageWidth) = repmat(inputImage(1, :), padH, 1);
    % Pad righe inferiori
    paddedImage(padH+imageHeight+1:end, padW+1:padW+imageWidth) = repmat(inputImage(end, :), padH, 1);
    % Pad colonne sinistre
    paddedImage(:, 1:padW) = repmat(paddedImage(:, padW+1), 1, padW);
    % Pad colonne destre
    paddedImage(:, padW+imageWidth+1:end) = repmat(paddedImage(:, padW+imageWidth), 1, padW);

    paddedHeight = size(paddedImage, 1);
    paddedWidth = size(paddedImage, 2);

    % Linearizzazione immagine padded
    paddedVector = paddedImage(:);

    % Linearizzazione kernel
    kernelVector = kernel(:);

    % Costruzione Look-Up Table (offsets relativi ai pixel centrali nel padded)
    offsets = [];
    for rowShift = -padH:padH
        for colShift = -padW:padW
            offsets(end+1) = rowShift * paddedWidth + colShift;
        end
    end

    % Preallocazione output come vettore (dimensione originale)
    outputVector = zeros(imageHeight * imageWidth, 1, 'single');

    % Convoluzione su tutti i pixel dell'immagine originale,
    % ma con accesso all'immagine padded (indice calcolato nel padded)
    for row = 1:imageHeight
        for col = 1:imageWidth
            % Indice pixel centrale nell'immagine padded
            i = (row - 1 + padH) * paddedWidth + (col + padW);
            t = 0;
            for j = 1:length(kernelVector)
                t = t + kernelVector(j) * paddedVector(i + offsets(j));
            end
            outputVector((row - 1) * imageWidth + col) = t;
        end
    end

    % Ricostruzione immagine output
    outputImage = reshape(outputVector, imageHeight, imageWidth);
end
