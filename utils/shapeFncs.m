function shapeF = shapeFncs(x, k, n, a)

l = a / n;

if k == n
    if (n-1) * l <= x && x <= n*l
        shapeF = (x - (n-1) * l) / l;
    else
        shapeF = 0;
    end
else
    if (k-1) * l <= x && x <= k * l
        shapeF = (x - (k-1) * l) / l;
    else if k * l < x && x <= (k + 1) * l
        shapeF = ((k+1)*l - x) / l;
    else
        shapeF = 0;
    end
end
end
