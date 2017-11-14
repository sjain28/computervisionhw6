function showLambda(I, fig)

if nargin < 2 || isempty(fig)
    fig = 1;
end

figure
clf
imagesc(log(1 + I))
axis image
axis off
set(gcf, 'Color', 'w')
