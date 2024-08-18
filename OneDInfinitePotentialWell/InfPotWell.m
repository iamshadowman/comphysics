clear;
close;

x(1)=0;
y(1)=0;
u(1)=1;
h=0.001;
N=5000;
E=0;
E0=0;
dE=5e-3;
y1=0;

n = input('Enter the number of energy states including ground state\n');
fprintf('Wait till we process...\n')

for l=1:n

  while E>=0

    %ODE solver - RK4
    [~,y,x]=odesolver(E);
    %ending of RK4

    y2 = y((4/h)+1);
    E1 = E-dE;
    E2 = E;

    if y1*y2<0
      break
    end

    E = E+dE;
    y1 = y2;
  end

  E0(l) = bisection(E1, E2);
  [~, y0 ,~] = odesolver(E0(l));

  E = E0(l)+dE;
  y1 = y2;

  psi(l,:) = y0;
  plot(x, psi(l,:))
  hold on

  legendEntries{l} = sprintf('n=%d', l-1);
end

hold off
legend (legendEntries)
fprintf('Processing completed.\n')
fprintf('The energy eigen values are \n')
disp(E0)

xlabel('x')
ylabel('Ψ(x)')
xlim([0, 4])
title('1D infinite potential well')
grid on

