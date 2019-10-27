function err = oblicz_sume_bledow_ponownie(Z_exp, moduly, parametry, czestotliwosci, wskaznik)

Z_sym = wykonaj_symulacje(moduly, parametry, czestotliwosci);
error_diff = Z_sym - Z_exp;
error_sum = sum(abs(error_diff.*wskaznik).^2);
err = error_sum;

end