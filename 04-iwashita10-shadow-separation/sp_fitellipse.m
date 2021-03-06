function sp = sp_fitellipse(bwb, bws, ky, dbg)
% function sp = sp_fitellipse(bwb, bws, ky, dbg)

% fitellipse
ab = myfitellipse(bwb,   dbg);
as = myfitellipse(bws, dbg);

as(2) = as(2) + ky - 1;

m(1) = tan(ab(5));     b(1) = ab(2) - m(1) * ab(1);
m(2) = tan(as(5));     b(2) = as(2) - m(2) * as(1);

if abs(90 - rad2deg(ab(5))) < 5
    x0 = ab(1);
    y0 = m(2) * x0 + b(2);
else
    x = 1:size(bwb, 2);

    y1 = m(1)*x + b(1);
    y2 = m(2)*x + b(2);

    [x0, y0] = meetpoint(x, y1, x, y2);
end

sp = [x0(1), y0(1)];

if dbg
    bw = [bwb; bws];
    
    figure(41)
    imshow(bw);
    
    hold on
    ellipse(ab(3), ab(4), ab(5), ab(1), ab(2), 'r');
    ellipse(as(3), as(4), as(5), as(1), as(2), 'r');
    hold off
end