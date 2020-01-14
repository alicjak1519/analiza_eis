function czestotliwosci = wczytaj_czestotliwosci(filename)

%% Import data from text file.
% Script for importing data from the text file

%% Initialize variables.
% filename = '/home/aak/Documents/inzynierka/test 2.LCR';
delimiter = ' ';
startRow = 5;
endRow = 17;

%% Format for each line of text:
formatSpec = '%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Create output variable
macierz_czestotliwosci = [dataArray{1:end-1}];

czestotliwosci = [];
[liczba_wierszy, liczba_kolumn] = size(macierz_czestotliwosci);

for i = 1:liczba_wierszy
    for j = 1:liczba_kolumn
        if isnan(macierz_czestotliwosci(i,j)) == false
            czestotliwosci = [czestotliwosci macierz_czestotliwosci(i,j)];
        end
    end
end

czestotliwosci = czestotliwosci';

%% Clear temporary variables
clearvars i j liczba_kolumn liczba_wierszy macierz_czestotliwosci filename delimiter startRow endRow formatSpec fileID dataArray ans;

end