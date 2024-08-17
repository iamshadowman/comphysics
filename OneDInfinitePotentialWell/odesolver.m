function [out1, out2, out3]=odesolver(E)
  E=E;
  x(1)=0;
  y(1)=0;
  u(1)=1;
  h=0.001;
  N=5000;

  %ODE solver - Starting of RK4
  g=@(x,y) -E*y; %du/dx=-Ey
  f=@(x,u) u; %dy/dx=u

  for i=1:N

    %RK4
    %u
    k1=g(x(i),y(i));
    k2=g(x(i)+h/2,y(i)+k1*h/2);
    k3=g(x(i)+h/2,y(i)+k2*h/2);
    k4=g(x(i)+h,y(i)+k3*h);
    u(i+1)=u(i)+(k1 + 2*k2 + 2*k3 + k4)*h/6;

    %y
    j1=f(x(i),u(i));
    j2=f(x(i)+h/2,u(i)+j1*h/2);
    j3=f(x(i)+h/2,u(i)+j2*h/2);
    j4=f(x(i)+h,u(i)+j3*h);
    y(i+1)=y(i)+(j1 + 2*j2 + 2*j3 + j4)*h/6;


    x(i+1)=x(i)+h;
  end
  %ending of RK4
  out1 = y((4/h)+1);
  out2 = y;
  out3 = x;
end
