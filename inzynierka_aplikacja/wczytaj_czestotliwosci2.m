function czestotliwosci = wczytaj_czestotliwosci2(filename)

%% Import data from text file.
% Script for importing data from the following text file:
%
%    /home/aak/Documents/inzynierka/test 2.LCR
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2019/09/09 12:52:17

%% Initialize variables.
% filename = '/home/aak/Documents/inzynierka/test 2.LCR';
delimiter = ' ';
startRow = 5;
endRow = znajdzStartRow(filename) - 1;

%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines', startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
macierz_czestotliwosci = [dataArray{1:end-1}];

czestotliwosci = [];
[liczba_wierszy, liczba_kolumn] = size(macierz_czestotliwosci)

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