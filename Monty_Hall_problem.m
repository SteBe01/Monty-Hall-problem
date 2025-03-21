%% Monty Hall problem

clear, clc
close all

matches = 1e5;

tic
array = zeros(matches, 3);
for ii = 1:length(array)
    prize = randi(3);
    array(ii,prize) = 1;
end

results1 = zeros(length(array),1);
results2 = zeros(length(array),1);

for ii = 1:length(array)
    choice = randi(3);

    [idx] = presenter(array(ii,:), choice);

    alternatives = [1 2 3];
    new_choice = ~ismember(alternatives,[choice idx]);
    new_choice = find(new_choice == 1);

    % stay
    if array(ii,choice) == 1
        results1(ii) = 1;
    end

    % change
    if array(ii,new_choice) == 1
        results2(ii) = 1;
    end
end

wins_stay = sum(results1);
wins_change = sum(results2);

run_time = toc;

fprintf("Game run in %.4f seconds for %i matches: %i stay wins and %i change wins\n", run_time, matches, wins_stay, wins_change)
fprintf("- Stay wins: \t %.2f%%\n- Change wins: \t %.2f%%\n", wins_stay/matches*100, wins_change/matches*100)


%% Functions

function [idx] = presenter(line, choice)
    line(choice) = line(choice) + 1;
    line = ~line;

    line_pos = [1 2 3];
    new_vect = nonzeros(line_pos.*line);
    if isscalar(new_vect)
        idx = new_vect;
    else
        idx = randi(new_vect);
    end
end

