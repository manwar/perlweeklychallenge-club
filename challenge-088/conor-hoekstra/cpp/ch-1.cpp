// Godbolt Link: https://godbolt.org/z/dGGKzdYhn

#include <algorithm>
#include <numeric>
#include <vector>
#include <functional>

auto array_product(std::vector<int> v) -> std::vector<int> {
    auto const prod = std::accumulate(v.cbegin(), v.cend(), 1, std::multiplies{});
    std::transform(v.cbegin(), v.cend(), v.begin(), [=] (auto e) { return prod / e; });
    return v;
}
