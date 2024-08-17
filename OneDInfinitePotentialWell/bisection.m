function t = bisection(a, b)
    m = a;
    n = b;
    tol = 0.001;
    while abs(n - m) > tol
        if odesolver_out1(m) * odesolver_out1(n) < 0
            c = (m + n) / 2;
            if odesolver_out1(n) * odesolver_out1(c) > 0
                n = c;
            elseif odesolver_out1(n) * odesolver_out1(c) < 0
                m = c;
            end
        end
    end
    t = (m + n) / 2;
end

function out1 = odesolver_out1(x)
    [out1,~,~] = odesolver(x); % Assuming odesolver's first output is what you need
end
