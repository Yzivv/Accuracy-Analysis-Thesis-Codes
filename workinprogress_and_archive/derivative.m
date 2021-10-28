
function dy = derivative (x, y)
  N = length(x);
  dy = zeros(1,N);
  h = x(2)-x(1);
  a = diff(y)./h;
  dy(1:N-1) = a;
  dy(N) = dy(N-1);
end
