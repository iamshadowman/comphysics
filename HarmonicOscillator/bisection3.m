function t = bisection3(a, b, l)
    m = a;
    n = b;
    l = l;
    tol = 0.001;
    while abs(n - m) > tol
        if odesolver_out1(m,l) * odesolver_out1(n,l) < 0
            c = (m + n) / 2;
            if odesolver_out1(n,l) * odesolver_out1(c,l) > 0
                n = c;
            elseif odesolver_out1(n,l) * odesolver_out1(c,l) < 0
                m = c;
            end
        end
    end
    t = (m + n) / 2;
end

function out1 = odesolver_out1(x,l)
    [out1,~,~,~] = odesolver3(x,l); % Assuming odesolver's first output is what you need
end
