
#include <span>
#include <ranges>
#include <iostream>
#include <string_view>

std::ostream& operator<<(std::ostream &o, std::ranges::range auto r) {
  if( begin(r) == end(r) ) return o;
  std::copy(begin(r), end(r)-1, std::ostream_iterator<decltype(*begin(r))>{o, ", "});
  return o << end(r)[-1];
}

int main(int argc, char **argv) {
  if( argc <= 1 ) return 0;
  int needle = std::stoi(argv[1]);
  auto e = std::remove_if(argv+2, argv+argc, [=](auto x){ return std::stoi(x) <= needle; });
  std::cout << std::span{ argv+2, e } << '\n';
}

