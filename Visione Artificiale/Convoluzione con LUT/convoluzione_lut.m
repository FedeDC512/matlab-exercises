function outputImage = convoluzione_lut(inputImage, kernel)

    [imageHeight, imageWidth] = size(inputImage);
    inputVector = single(inputImage(:));  % Linearizza l'immagine in un vettore colonna

    [kernelHeight, kernelWidth] = size(kernel);
    kernelVector = kernel(:); % Linearizza anche il kernel (per indicizzazione lineare)

    padH = floor(kernelHeight / 2);
    padW = floor(kernelWidth / 2);

    % Costruzione della Look-Up Table (offsets relativi ai pixel centrali)
    offsets = [];
    for rowShift = -padH:padH
        for colShift = -padW:padW
            offsets(end+1) = rowShift * imageWidth + colShift;
        end
    end

    % Preallocazione immagine di output come vettore
    outputVector = zeros(imageHeight * imageWidth, 1, 'single');

    % Convoluzione: solo per i pixel centrali (salta i bordi)
    for row = 1 + padH : imageHeight - padH
        for col = 1 + padW : imageWidth - padW
            i = (row - 1) * imageWidth + col;  % indice lineare
            t = 0;
            for j = 1:length(kernelVector)
                t = t + kernelVector(j) * inputVector(i + offsets(j));
            end
            outputVector(i) = t;
        end
    end

    % Ricostruzione dell'immagine 2D
    outputImage = reshape(outputVector, imageHeight, imageWidth);
end
