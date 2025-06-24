img = imread('circuit.tif');
bw = edge(img, 'canny'); % Estrazione dei bordi

% Trasformata di Hough
[H, theta, rho] = hough(bw);

% Trova i picchi nella trasformata
peaks = houghpeaks(H, 5); % Trova fino a 5 linee

% Trova le linee
lines = houghlines(bw, theta, rho, peaks);

% Visualizza
figure;
imshow(bw);

figure;
imshow(img); hold on;
title('Linee rilevate con Trasformata di Hough');

for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'red');
end