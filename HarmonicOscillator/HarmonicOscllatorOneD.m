clear;
close all;

h=0.001;
E=0;
E0=0;
dE=5e-3;
y1=0;

n = input('Enter the number of energy states including ground state\n');
fprintf('Wait till we process...\n')

for l=1:n

  while E>=0

    %ODE solver - RK4
    [y2,y,x,~]=odesolver3(E,l);

    y2 = y2;
    E1 = E-dE;
    E2 = E;
    p=y1*y2;
    if y1*y2<0
      break
    end

    E = E+dE;
    y1 = y2;
  end

  E0(l) = bisection3(E1, E2, l);
  [~, y0,x0 , b] = odesolver3(E0(l),l);

  E = E0(l)+dE;
  y1 = 0;
  y2 = 0;

  half_psi = y0;
  half_dist = x0;

  full_dist = [-flip(half_dist), half_dist];

  if mod(l,2) == 0
      full_psi = [-flip(half_psi), half_psi];
  else
      full_psi = [flip(half_psi), half_psi];
  end

  dist{l} = full_dist;
  psi{l} = full_psi;

  plot(dist{l}, psi{l})
  hold on

  legendEntries{l} = sprintf('n=%d', l-1);
end

plot([-flip(x0),x0],[flip(b),b])
hold off

legendEntries{l+1} = '(1/2)kx^2';
legend (legendEntries)
fprintf('Processing completed.\n')
fprintf('The energy eigen values are \n')
disp(E0)

xlabel('x')
ylabel('Ψ(x)')
ylim([-6, 6])
xlim([-5, 5])
title('1D harmonic oscillator')
grid on
