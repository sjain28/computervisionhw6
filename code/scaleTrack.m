function d = scaleTrack(I, J, xI, sigma)
    pI = gaussianPyramid(I, 0.5);
    pJ = gaussianPyramid(J, 0.5);
    d = lucas_kanade(pI{4}, pJ{4}, xI/8, sigma);
    
    for i = 3:1    
       d = lucas_kanade(pI{i}, pJ{i}, xI/(2^(i-1)), sigma, d*2);    
    end
end

