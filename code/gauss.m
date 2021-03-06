% With normalized == 0, returns samples of a 1D Gaussian with the given
% mean and standard deviation. With normalized == 1, adjusts normalization
% so that the sum of the samples is one.
function g = gauss(x, m, sigma, normalized)

if nargin < 4
    normalized = 0;
end

g = exp(- (((x - m)/ sigma) .^ 2) / 2) / sqrt(2 * pi) / sigma;

if normalized
    g = g / sum(g);
end

%x and m only matter to the extent that m is the center of the range, so
%that the distribution is symmetric

%normalized = 1, sigma is given

% Just ask how large to make the window