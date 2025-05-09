function angolo(img)

[bordo, ~, dy, dx] = edge(rgb2gray(img), 'sobel');
angolo = atan2(-dy, -dx);
direzione = round(254*(angolo+pi)/(2*pi))+1;
direzione(bordo==0) = 0;

figure; imshow(img, []);
figure; imshow(direzione, [[0 0 0]; hsv(255)]);
