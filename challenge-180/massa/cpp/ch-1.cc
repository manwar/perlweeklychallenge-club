
#include <span>
#include <ranges>
#include <iostream>
#include <string_view>

template <std::input_iterator It, std::sentinel_for<It> S>
It first_unique(It begin, S end) {
  for( auto it = begin; it != end; ++it )
    if( std::find(begin, it, *it) == it && std::find(it+1, end, *it) == end )
      return it;
  return end;
}

auto first_unique(std::ranges::input_range auto range) {
  return first_unique(begin(range), end(range));
}

int main(int argc, char **argv) {
  for( std::string_view a: std::span { argv+1, argv+argc } ) {
    auto u = first_unique(a);
    std::cout << (u == std::end(a) ? -1 : u - std::begin(a)) << ' ' << a << '\n';
  }
}

