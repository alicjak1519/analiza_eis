function wynik_dla_temp = optymalizuj_ponownie(wynik, numer_pomiaru, moduly, wskaznik)

Z_exp = wynik(numer_pomiaru).impedancja.Z_exp;
parametry = wynik(numer_pomiaru).wektor;
czestotliwosci = wynik(numer_pomiaru).impedancja.czestotliwosc;

suma_bledow = @(parametry) oblicz_sume_bledow_ponownie(Z_exp, moduly, parametry, czestotliwosci, wskaznik);
[dolna_granica, gorna_granica] = wyznacz_granice(moduly);
optionsN = optimoptions('fmincon');

wektor_parametrow = fmincon(suma_bledow, parametry, [], [], [], [], dolna_granica, gorna_granica, [], optionsN);
Z_sym = wykonaj_symulacje(moduly, wektor_parametrow, czestotliwosci);
blad_bezwzgledny = oblicz_sume_bledow_ponownie(Z_exp, moduly, wektor_parametrow, czestotliwosci, wskaznik);

wynik_dla_temp.wektor = wektor_parametrow;
wynik_dla_temp.blad = blad_bezwzgledny;
wynik_dla_temp.temperatura = wynik(numer_pomiaru).temperatura;
wynik_dla_temp.impedancja.czestotliwosc = wynik(numer_pomiaru).impedancja.czestotliwosc;
wynik_dla_temp.impedancja.Z_exp = Z_exp.*wskaznik;
wynik_dla_temp.impedancja.Z_sym = Z_sym.*wskaznik;
wynik_dla_temp.min_czestotliwosc = czestotliwosci(1);
wynik_dla_temp.max_czestotliwosc = czestotliwosci(end);

end