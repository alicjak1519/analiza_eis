% Obliczenie impedancji Warburga

function ZW = oblicz_impedancje_W(Z0,w)

ZW = Z0*(1-1j)./sqrt(w);

end


