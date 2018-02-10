function t = addzeros(v,E)

    t = zeros(length(E),1);
    k = 1;
    t(find(E>0.5))=v;


end

