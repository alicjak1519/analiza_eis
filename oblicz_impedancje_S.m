% Obliczanie impedancji CPE

function ZCPE = oblicz_impedancje_S(A,Y0,w)

ZCPE = 1./((1j*w).^A *Y0 );

end