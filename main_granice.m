function wynik = main_granice(sciezka_pliku, moduly, parametry, dolna_granica, gorna_granica)

%% Wczytywanie wynikow z pomiarow

[Z_exp_calosc, liczba_pomiarow] = wczytaj_LRC(sciezka_pliku);
czestotliwosci = wczytaj_czestotliwosci(sciezka_pliku);

%% Dane do symulacji

% wprowadzane z pliku

%% Optymalizacja

for numer_pomiaru = 1:liczba_pomiarow

Z_exp = Z_exp_calosc(numer_pomiaru).imp;

suma_bledow = @(parametry) oblicz_sume_bledow(Z_exp, moduly, parametry, czestotliwosci);
% [dolna_granica, gorna_granica] = wyznacz_granice(moduly);
optionsN = optimoptions('fmincon');

wektor_parametrow = fmincon(suma_bledow, parametry, [], [], [], [], dolna_granica, gorna_granica, [], optionsN);

Z_sym = wykonaj_symulacje(moduly, wektor_parametrow, czestotliwosci);


%% Wyświetlenie wynikow - rysowanie wykresu, dopasowany wektor parametrow

% realizowane w appdesigner

%% Podsumowanie

temperatura = Z_exp_calosc(numer_pomiaru).temperature;

blad_bezwzgledny = oblicz_sume_bledow(Z_exp, moduly, wektor_parametrow, czestotliwosci);

wynik(numer_pomiaru) = podsumuj(wektor_parametrow, blad_bezwzgledny, temperatura, Z_exp, Z_sym, czestotliwosci);

end
end