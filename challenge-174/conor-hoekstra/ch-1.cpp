
#include <algorithm>
#include <cmath>
#include <iostream>
#include <numeric>
#include <string>

namespace rv = std::views;

auto is_disarium(int n) -> bool {
  auto const s = std::to_string(n);
  return n == std::transform_reduce(
                  s.cbegin(), s.cend(), rv::iota(1).begin(), 0, std::plus{},
                  [](auto c, auto i) { return std::pow(c - 48, i); });
}

auto main() -> int {

  auto c = 0;
  auto i = 0;

  while (c < 19) {
    if (is_disarium(i)) {
      ++c;
      std::cout << i << ' ';
    }
    ++i;
  }
  std::cout << '\n';

  return 0;
}
