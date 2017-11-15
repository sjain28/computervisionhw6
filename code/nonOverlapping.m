function ol = nonOverlapping(idxList, idx, I, radius)
 [r,c] = ind2sub(size(I), idx);
 [coords(1,:), coords(2,:)] = ind2sub(size(I), idxList);
 coords = coords - [r;c];
 distances = sqrt(sum(coords.^2));
 ol = idxList(distances > radius);
end