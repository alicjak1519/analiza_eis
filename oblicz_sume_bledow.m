function err = oblicz_sume_bledow(Z_exp, moduly, parametry, czestotliwosci)

Z_sym = wykonaj_symulacje(moduly, parametry, czestotliwosci);
error_diff = Z_sym - Z_exp;
error_sum = sum(abs(error_diff).^2);
err = error_sum;

end