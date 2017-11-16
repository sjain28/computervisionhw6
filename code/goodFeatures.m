function [pos, lambda] = goodFeatures(I, sigma, lambdaThresh, nMax, minDist, margin)
    lam = smallEigenvalue(I, sigma);
    [~, idx] = sort(lam(:), 'descend');
    
    finalIndices = []; 
    
    for i = 1:nMax
        
        if isempty(idx)
            break
        end
        
        if lam(idx(1)) < lambdaThresh
            break
        end
        
        if nearBoundary(idx(1), size(I), margin)
            idx = idx(2:end);
        else
            finalIndices = [finalIndices idx(1)];
            idx = nonOverlapping(idx, idx(1), I, minDist);
        end
    end
    
    [R, C] = ind2sub(size(I), finalIndices);
    pos(1,:) = R;
    pos(2,:) = C;
    
    lambda = lam(finalIndices);
     
end