%    function p = gaussianPyramid(img, factor, levels)
%
% Compute a Gaussian pyramid of input image img with the given sampling
% factor, which must be strictly between 0 and 1

function p = gaussianPyramid(img, factor)

if nargin < 2 || isempty(factor)
    factor = 1/2;
else
    if factor <= 0 || factor >= 1
        error('Sampling factor must be between 0 and 1 not inclusive')
    end
end

levels = floor(-log(min(size(img)))/log(factor));

p = cell(1, levels);
p{1} = img;
for k = 2:levels
    p{k} = imresize(p{k-1}, factor);
end