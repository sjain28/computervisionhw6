% Inputs:
%   I: first frame (gray level).
%   J: second frame (gray level).
%   xI: an n by 2 array of starting positions in I.
%   displ (optional: an n by 2 array of displacement predictions. If not
%       given, the predictions are zero.
%
% Outputs:
%   displ: an n by 2 array of displacements. Yuo can compute the
%   corresponding positions in J as xJ = xI + displ.

function displ = lucas_kanade(I, J, xI, sigma, displ)

if nargin < 5
    % Default prediction is no motion
    displ = zeros(size(xI));
end

% Maximum number of iterations
maxIter = 30;

% Desired precision in the result (pixels)
precision = 0.2;

% Number of points
n = size(xI, 2);

% Size of tracking window (make it a square with odd sidelength)
half = ceil(2.5 * sigma);
winsize = (2 * half + 1) * [1 1];

% Motions greater than this are suspicious
maxMotion = ceil(winsize(1) * 0.6);

gr = grad(I);
Ir = gr{1};
Ic = gr{2};

% Square root of a Gaussian filter
g = gauss(-half:half, 0, sigma, 1);
w = g(:) * g(:)';
w = sqrt(w(:));

% Sub-pixel interpolation method
method = 'linear';

for i = 1:n
    % Skip lost features
    if isnan(xI(1, i)) || isnan(displ(1, i))
        displ(:, i) = NaN;
        continue;
    end
    
    rows = xI(1, i)+(-half:half);
    cols = xI(2, i)+(-half:half);
    
    % Stay inside the image (assumes that motion is less than 'half')
    if min(rows) < half || min(cols) < half || ...
            max(rows) > size(I, 1) - half || max(cols) > size(I, 2) - half
        displ(:, i) = NaN;
        fprintf('Warning: Lost feature %d, too close to image boundary\n', ...
            i);
        continue;
    end
    
    % Derivatives in the first frame are computed only once
    Iwin = interp2(I, cols, rows', method);
    r = interp2(Ir, cols, rows', method);
    c = interp2(Ic, cols, rows', method);
    
    % Ditto for the left-hand side of the normal equations
    G = [w.*r(:) w.*c(:)];
    A = G'*G;
    
    d = displ(:, i);
    d0 = d;
    for m = 1:maxIter
        
        % Subpixel interpolation for the second frame
        rr = rows + d(1);
        cc = cols + d(2);
        Jwin = interp2(J, cc, rr', method);
        
        t = Jwin - Iwin;
        
        % Right-hand side of the normal equations
        b = - w .* t(:);
        b = G' * b;
        
        % Solve A*x = b
        step = A\b;
        
        % Update displacement
        d = d + step;
        
        % Done
        if norm(step) < precision
            break;
        end
        
        % Failed
        if norm(d - d0) > maxMotion
            % Probably lost
            fprintf('Warning: Lost feature %d, motion %f > %g\n', ...
                i, norm(d), maxMotion);
            d = [NaN; NaN];
            break;
        end
    end
    
    % Not converged soon enough
    if m >= maxIter
        fprintf('Warning: Lost feature %d: more than %d iterations', ...
            i, m);
        fprintf(' (precision target %g pixels)\n', precision);
        d = [NaN; NaN];
    end
    
    displ(:, i) = d;
end