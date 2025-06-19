function img_rec = ANSEI_decode(compressed)
    CTRL = compressed.CTRL;
    DATA = compressed.DATA;
    map = compressed.map;
    H = compressed.H;
    W = compressed.W;

    img_rec = zeros(H, W, 3);
    N = H * W;

    % Primo pixel
    RGB_prev = map(DATA(1) + 1, :);
    img_rec(1,1,:) = RGB_prev;

    count = 1;
    for y = 1:H
        for x = 1:W
            if y == 1 && x == 1, continue; end
            count = count + 1;

            switch CTRL(count)
                case 0
                    RGB_new = map(DATA(count) + 1, :);
                case 1
                    RGB_new = [DATA(count), RGB_prev(2:3)];
                case 2
                    RGB_new = [RGB_prev(1), DATA(count), RGB_prev(3)];
                case 3
                    RGB_new = [RGB_prev(1:2), DATA(count)];
            end
            img_rec(y, x, :) = RGB_new;
            RGB_prev = RGB_new;
        end
    end

    img_rec = im2uint8(img_rec);  % Ritorna in uint8
end