function wynik = podsumuj(wektor_parametrow, blad, temperatura, Z_exp, Z_sym, czestotliwosci)

wynik.wektor = wektor_parametrow;
wynik.blad = blad;
wynik.temperatura = temperatura;
wynik.impedancja.czestotliwosc = czestotliwosci;
wynik.impedancja.Z_exp = Z_exp;
wynik.impedancja.Z_sym = Z_sym;
wynik.min_czestotliwosc = czestotliwosci(1);
wynik.max_czestotliwosc = czestotliwosci(end);

end