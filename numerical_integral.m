function rocket_integration()
    
    func = @(t) (2000 * log(140000 ./ (140000 - 2100 * t))) - (9.8 * t);

    
    t0 = 8;
    tf = 30;
    
    
    single_trap = trapezoidal_rule(func, t0, tf, 1);
    single_simpson = simpsons_rule(func, t0, tf, 1);
    
    
    true_value = integral(func, t0, tf);
    
    
    Et_trap = true_value - single_trap;
    eta_trap = abs(Et_trap / true_value);
    
    Et_simpson = true_value - single_simpson;
    eta_simpson = abs(Et_simpson / true_value);
    
   
    fprintf('Single-segment Trapezoidal Rule: %.4f\n', single_trap);
    fprintf('True Error (Trapezoidal): %.4f\n', Et_trap);
    fprintf('Absolute Relative True Error (Trapezoidal): %.4f%%\n', eta_trap * 100);
    
    fprintf('Single-segment Simpson''s Rule: %.4f\n', single_simpson);
    fprintf('True Error (Simpson): %.4f\n', Et_simpson);
    fprintf('Absolute Relative True Error (Simpson): %.4f%%\n', eta_simpson * 100);
    
    
    multi_trap = trapezoidal_rule(func, t0, tf, 5);
    multi_simpson = simpsons_rule(func, t0, tf, 5);
    
    
    Et_trap_multi = true_value - multi_trap;
    eta_trap_multi = abs(Et_trap_multi / true_value);
    
    Et_simpson_multi = true_value - multi_simpson;
    eta_simpson_multi = abs(Et_simpson_multi / true_value);
    
    
    segments = 1:5;
    trap_results = arrayfun(@(n) trapezoidal_rule(func, t0, tf, n), segments);
    simpson_results = arrayfun(@(n) simpsons_rule(func, t0, tf, n), segments);
    
    trap_errors = true_value - trap_results;
    simpson_errors = true_value - simpson_results;
    
    figure;
    subplot(2,1,1);
    plot(segments, trap_errors, '-o', segments, simpson_errors, '-*');
    title('Error vs. Number of Segments');
    xlabel('Number of Segments');
    ylabel('True Error');
    legend('Trapezoidal', 'Simpson');
    
    subplot(2,1,2);
    plot(segments, trap_results, '-o', segments, simpson_results, '-*');
    title('Integration Result vs. Number of Segments');
    xlabel('Number of Segments');
    ylabel('Integration Result');
    legend('Trapezoidal', 'Simpson');
end

function result = trapezoidal_rule(func, a, b, n)
    h = (b - a) / n;
    x = a:h:b;
    y = func(x);
    result = (h/2) * (y(1) + 2*sum(y(2:end-1)) + y(end));
end

function result = simpsons_rule(func, a, b, n)
    h = (b - a) / n;
    x = a:h:b;
    y = func(x);
    result = (h/3) * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));
end


