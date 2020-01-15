function ZP = oblicz_impedancje_P(R,Y0, A, w)

ZR = oblicz_impedancje_R(R);
ZC = oblicz_impedancje_S(Y0, A, w);

S =  1/ZR + 1./ZC;
ZP = 1./S;
end
