function lambdaMin = smallEigenvalue(I, sigma)
    I = double(I); 
    [gradient, ~, ~] = grad(I, sigma);
    Gx = gradient{1};
    Gy = gradient{2};
    
    a = Gx.^2;
    d = Gx.*Gy;
    b = Gy.^2;
    
    windowSize = ceil(2.5*sigma);
    window1 = gauss(-windowSize:windowSize, 0, sigma, 1);
    window2 = window1';
    
    p = conv2(a, window1, 'same');
    p = conv2(p, window2, 'same');
    r = conv2(d, window1, 'same');
    r = conv2(r, window2, 'same');
    q = conv2(b, window1, 'same');
    q = conv2(q, window2, 'same');
    
    S = p + q;
    D = sqrt((p-q).^2 + 4*r.^2);
    lambdaMin = S-D;
end