function nowy_wynik_temp = uwzglednij_wskaznik_czestotliwosci(wynik, numer_pomiaru, moduly, min_czestotliwosc, max_czestotliwosc, liczba_uwzglednianych_pomiarow)

liczba_pomiarow = length(wynik(numer_pomiaru).impedancja.Z_exp);

wskaznik = dobierz_wskaznik_czestotliwosci(wynik, numer_pomiaru, liczba_pomiarow, min_czestotliwosc, max_czestotliwosc);

nowy_wynik_temp = optymalizuj_ponownie(wynik, numer_pomiaru, moduly, wskaznik);

end