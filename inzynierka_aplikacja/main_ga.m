function wynik = main_ga(sciezka_pliku, moduly, dolna_granica, gorna_granica)

%% Wczytywanie wynikow z pomiarow

[Z_exp_calosc, liczba_pomiarow] = wczytaj_LRC2(sciezka_pliku);
czestotliwosci = wczytaj_czestotliwosci2(sciezka_pliku);

%% Dane do symulacji

% przyjmowane od użytkownika
liczba_parametrow = policz_parametry(moduly);

%% Optymalizacja

for numer_pomiaru = 1:liczba_pomiarow

    Z_exp = Z_exp_calosc(numer_pomiaru).imp;

    suma_bledow = @(parametry) oblicz_sume_bledow(Z_exp, moduly, parametry, czestotliwosci);

    ga_wektor_parametrow = ga(suma_bledow, liczba_parametrow, [], [],[] ,[], dolna_granica, gorna_granica);

    Z_sym = wykonaj_symulacje(moduly, ga_wektor_parametrow, czestotliwosci);

    
    %% Podsumowanie

    temperatura = Z_exp_calosc(numer_pomiaru).temperature;
    blad_bezwzgledny = oblicz_sume_bledow(Z_exp, moduly, ga_wektor_parametrow, czestotliwosci);

    wynik(numer_pomiaru) = podsumuj(ga_wektor_parametrow, blad_bezwzgledny, temperatura, Z_exp, Z_sym, czestotliwosci);

end

%% Wyświetlenie wynikow - rysowanie wykresu, dopasowany wektor parametrow

    % wyswietlanie w aplikacji

end