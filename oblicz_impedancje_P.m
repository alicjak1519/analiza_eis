function ZP = oblicz_impedancje_P(R,C,w)
 
ZR = oblicz_impedancje_R(R);
ZC = oblicz_impedancje_C(C,w);

S =  1/ZR + 1./ZC;
 
ZP = 1./S;

end