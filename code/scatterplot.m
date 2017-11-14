function scatterplot(d, fig)

if nargin < 2 || isempty(fig)
    fig = 1;
end

figure(fig)
clf
hold on
gray = 0.7 * [1 1 1];
plot(d(2, :), d(1, :), '.b', 'MarkerSize', 32)
axis equal
axis ij
xLim = get(gca, 'xLim');
yLim = get(gca, 'yLim');
plot([0 0], yLim, 'Color', gray)
plot(xLim, [0 0], 'Color', gray)
xlabel('column displacement')
ylabel('row displacement')