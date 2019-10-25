function wynik = main_ga(sciezka_pliku, moduly, parametry)

%% Wczytywanie wynikow z pomiarow

% sciezka_pliku = '/home/aak/Documents/inzynierka/LSGM-Test.LCR';
[Z_exp_calosc, liczba_pomiarow] = wczytaj_LRC(sciezka_pliku);
czestotliwosci = wczytaj_czestotliwosci(sciezka_pliku);

%% Dane do symulacji

% moduly = input("Podaj symbole modułów ", 's');
% moduly = 'PP';

% parametry = input("Podaj początkowe parametry w kwadratowych nawiasach (P = R C) ");
% parametry = [ 4 -9 4 -9 ];

%% Optymalizacja

for numer_pomiaru = 1:liczba_pomiarow
% numer_pomialength(parametry)ru = input("Podaj numer pomiaru ")
% numer_pomiaru = 1;

Z_exp = Z_exp_calosc(numer_pomiaru).imp;

suma_bledow = @(parametry) oblicz_sume_bledow(Z_exp, moduly, parametry, czestotliwosci);

[dolna_granica, gorna_granica] = wyznacz_granice(moduly);

ga_wektor_parametrow = ga(suma_bledow, length(parametry), [], [],[] ,[], dolna_granica, gorna_granica);

Z_sym = wykonaj_symulacje(moduly, ga_wektor_parametrow, czestotliwosci);


%% Wyświetlenie wynikow - rysowanie wykresu, dopasowany wektor parametrow
% plot(real(Z_exp),-imag(Z_exp),'r.', real(Z_sym), -imag(Z_sym), 'b-')

%% Podsumowanie

temperatura = Z_exp_calosc(numer_pomiaru).temperature;
blad_bezwzgledny = oblicz_sume_bledow(Z_exp, moduly, wektor_parametrow, czestotliwosci);

wynik(numer_pomiaru) = podsumuj(wektor_parametrow, blad_bezwzgledny, temperatura, Z_exp, Z_sym, czestotliwosci);

end
end