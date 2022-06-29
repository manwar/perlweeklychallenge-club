#include<iostream>
#include<functional>

std::function<int(int)> f = [](auto n){return n + 2;};
std::function<int(int)> g = [](auto n){return n * 2;};

template<typename F, typename G>
auto compose(F f, G g)
{
  return [f,g](auto n){return f(g(n));};
}

int main()
{
  std::cout << compose(f, g)(5) << '\n';
  return 0;
}
