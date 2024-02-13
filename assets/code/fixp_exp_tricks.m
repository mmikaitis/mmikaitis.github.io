inputs = [-25:0.01:-0.01];

% Compute exponentials and errors
errors = [];
for x = inputs 
    ref = exp(to_s1615(x));
    errors = [errors, (s1615_exp(x) - ref)];
end

errors_imprv = [];
for x = inputs
    trans_x = to_s1615(x+to_s1615(log(2)*16));
    ref = exp(to_s1615(x));
    errors_imprv = [errors_imprv, ...
        (s1615_exp(trans_x)/2^16 - ref)];
end

% Create a table to store data
T = table(inputs.', errors.', errors_imprv.', ...
    'VariableNames', { 'x', 'err1', 'err2'});
% Write data to a text file
writetable(T, 'absolute_errors.txt', 'Delimiter',' ');

plot(inputs, errors)
hold on
plot(inputs, errors_imprv)

    function y = s1615_exp(x)
        y = to_s1615(exp(to_s1615(x)));
    end

    function y = to_s1615(x)
        y = round(x * 2^15)/2^15;
    end