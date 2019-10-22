function optymalizuj_ponownie(wynik, numer_pomiaru, moduly)

Z_exp = wynik(numer_pomiaru).impedancja.Z_exp;
parametry = wynik(numer_pomiaru).wektor;
czestotliwosci = wynik(numer_pomiaru).impedancja.czestotliwosc

suma_bledow = @(parametry) oblicz_sume_bledow(Z_exp, moduly, parametry, czestotliwosci);
[dolna_granica, gorna_granica] = wyznacz_granice(moduly);
optionsN = optimoptions('fmincon');

wektor_parametrow = fmincon(suma_bledow, parametry, [], [], [], [], dolna_granica, gorna_granica, [], optionsN);
Z_sym = wykonaj_symulacje(moduly, wektor_parametrow, czestotliwosci);
blad_bezwzgledny = oblicz_sume_bledow(Z_exp, moduly, wektor_parametrow, czestotliwosci);

wynik(numer_pomiaru).wektor = wektor_parametrow;
wynik(numer_pomiaru).blad = blad_bezwzgledny;
wynik(numer_pomiaru).impedancja.Z_sym = Z_sym;

end