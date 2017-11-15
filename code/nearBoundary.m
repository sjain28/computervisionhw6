function r = nearBoundary(index, imSize, margin)
    [i, j] = ind2sub(imSize, index);
    
    if i <= margin | j <= margin | i > imSize(1)-margin | j > imSize(2) - margin
        r = true;   
    else
        r = false;
    end
end