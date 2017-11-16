function [s]  = plotLK(I, xI, d)
    
    imagesc(I);
    hold on
    [r,c] = size(xI);
    
    s =0;
    % for first figure
%     for i= 1:c
%         if isnan(d(1,i))
%             plot(xI(2,i), xI(1,i),'o','MarkerSize', 7, 'MarkerFaceColor', 'r', 'MarkerEdgeColor', 'b');
%         
%         else
%             plot(xI(2,i), xI(1,i),'o','MarkerSize', 7, 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'b');
%         end
%     end

    % for second figure
    for i= 1:c
        if ~isnan(d(1,i))
            plot(xI(2,i)+d(2,i), xI(1,i)+d(1,i),'o','MarkerSize', 7, 'MarkerFaceColor', 'g', 'MarkerEdgeColor', 'b');
        
        end
    end

end

