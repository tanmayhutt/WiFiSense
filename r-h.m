%% Routh-Hurwitz stability criterion
% The Routh-Hurwitz stability criterion is a necessary (and frequently
% sufficient) method to establish the stability of a single-input,
% single-output(SISO), linear time invariant (LTI) control system.
% More generally, given a polynomial, some calculations using only the
% coefficients of that polynomial can lead us to the conclusion that it
% is not stable.% in this program you must give your system coefficients and the
% Routh-Hurwitz table would be shown % Initialization
clear ;
close all;
clc
% Taking coefficients vector and organizing the first two rows
coeffVector = input('input vector of your system coefficients: \n i.e. [an an-1 an-2 ... a0] = ');
    ceoffLength = length(coeffVector);
    rhTableColumn = round(ceoffLength/2);
    % Initialize Routh-Hurwitz table with empty zero array
    rhTable = zeros(ceoffLength,rhTableColumn);
    % Compute first row of the table
    rhTable(1,:) = coeffVector(1,1:2:ceoffLength);
    % Check if length of coefficients vector is even or odd
    if (rem(ceoffLength,2) ~= 0)
    % if odd, second row of table will be
    rhTable(2,1:rhTableColumn - 1) = coeffVector(1,2:2:ceoffLength);
    else
        % if even, second row of table will be
        rhTable(2,:) = coeffVector(1,2:2:ceoffLength);
    end
    %% Calculate Routh-Hurwitz table's rows
    % Set epss as a small value
    epss = 0.01;
    % Calculate other elements of the table
    for i = 3:ceoffLength
        % special case: row of all zeros
        if rhTable(i-1,:) == 0
            order = (ceoffLength - i);
            cnt1 = 0;
            cnt2 = 1;
            for j = 1:rhTableColumn - 1
                rhTable(i-1,j) = (order - cnt1) * rhTable(i-2,cnt2);
                cnt2 = cnt2 + 1;
                cnt1 = cnt1 + 2;
            end
        end
        for j = 1:rhTableColumn - 1
            % first element of upper row
            firstElemUpperRow = rhTable(i-1,1);
            % compute each element of the table
            rhTable(i,j) = ((rhTable(i-1,1) * rhTable(i-2,j+1)) - (rhTable(i-2,1) * rhTable(i-1, j+1))) / firstElemUpperRow;
        end
        % special case: zero in the first column
        if rhTable(i,1) == 0
            rhTable(i,1) = epss;
        end
    end
    %% Compute number of right hand side poles(unstable poles)
    % Initialize unstable poles with zero
    unstablePoles = 0;
    % Check change in signs
    for i = 1:ceoffLength - 1
        if sign(rhTable(i,1)) * sign(rhTable(i+1,1)) == -1
            unstablePoles = unstablePoles + 1;
        end
    end
    % Print calculated data on screen
    fprintf('\n Routh-Hurwitz Table:\n')
    rhTable
    % Print the stability result on screen
    if unstablePoles == 0
        fprintf('~~~~~> it is a stable system! <~~~~~\n')
    else
        fprintf('~~~~~> it is an unstable system! <~~~~~\n')
    end
    fprintf('\n Number of right hand side poles =%2.0f\n',unstablePoles)
    reply = input('Do you want roots of system be shown? Y/N ', 's');
    if reply == 'y' || reply == 'Y'
        sysRoots = roots(coeffVector);
        fprintf('\n Given polynomial coefficients roots :\n')
        sysRoots
    end