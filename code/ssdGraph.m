function [e, dSpan] = ssdGraph(I, J, xI, sigma, h)
    dSpan = zeros(1, 2*h + 1);
    e = zeros(2*h+1,2*h+1);
    window1 = gauss(-h:h, 0, sigma, 1);
    window2 = window1';
    gaussMatrix = window1 * window2;
    i = I(xI(1)-h:xI(1)+h,xI(2)-h:xI(2)+h); 
    for d1 = -h : h
        dSpan(d1+h+1) = d1;
        for  d2 = -h : h
            j = J(xI(1)-h+d1:xI(1)+h+d1,xI(2)-h+d2:xI(2)+h+d2);
            dex1= d1+h+1;
            dex2 = d2+h+1;
            ssd = (i-j).^2;
            ssd = gaussMatrix.*ssd;
            e(dex1,dex2) = sum(sum(ssd))/numel(ssd);
        end
    end 
end

