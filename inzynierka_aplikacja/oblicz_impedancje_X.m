function ZX = oblicz_impedancje_X(R, A, Y0, w)

ZR = R;
ZS = oblicz_impedancje_S(A,Y0,w);
ZX = (ZR*ZS)/(ZR+ZS);

end
