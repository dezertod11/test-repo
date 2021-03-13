%% Изучение красного смещения

close all
clear variables
%% *Импорт данных*

spectra = importdata('spectra.csv');
starNames = importdata('star_names.csv');
lambdaStart = importdata('lambda_start.csv');
lambdaDelta = importdata('lambda_delta.csv');
%% Константы

lambdaPr = 656.28; %нм
speedOfLight = 299792.458; %км/с
%% Определение диапазона длин волн

nObs = size(spectra, 1); %кол-во наблюдений
lambdaEnd = lambdaStart + (nObs - 1)*lambdaDelta;
lambda = (lambdaStart : lambdaDelta : lambdaEnd)';
%% Расчёт скорости удаления звезды от Земли

nStars = size(starNames, 1); %кол-во звёзд
s = spectra;
[sHa, idx] = min(s);
lambdaHa = lambda(idx);

z = (lambdaHa / lambdaPr) - 1;
speed = z*speedOfLight;
%% Построение графика

fg1 = figure;
hold on;
for i = 1:nStars
    if speed(i)>0
        plot(lambda, s(:,i), 'LineWidth', 3);
    else
        plot(lambda, s(:,i), "--", 'LineWidth', 1);
    end
   
end

set(fg1, 'visible','on');
xlabel('Длина волны, нм');
ylabel(['Интенсивность, эрг/см^2/', char(197)]);
title('Спектры звезд');
grid on;
legend(starNames);
text(lambdaStart +5, max(s(1)) +2*10^(-14), 'Мальнев Александр, Б04-006');
hold off;
%% Сохранение графика

saveas(fg1, 'spectrs.png');
%% 
% Movaway

movaway = starNames(speed>0);