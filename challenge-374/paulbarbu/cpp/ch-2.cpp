// https://godbolt.org/z/MTM5WE1cj
// --stad=c++23
#include <print>
#include <ranges>
#include <string_view>
#include <vector>

auto largest_same_digits(std::string str)
{
    namespace rv = std::ranges::views;
    auto filtered = str | rv::filter([](auto c){return c != '0';});
    int start = 0;
    std::vector<std::string> candidates;
    while(start < std::ranges::distance(filtered.cbegin(), filtered.cend()))
    {
        auto dropped = filtered | rv::drop(start);
        auto front = dropped.front();
        auto run = dropped | rv::take_while([front](auto c){return c == front;}) | std::ranges::to<std::string>();

        candidates.push_back(run);
        start += run.size();
    }

    std::sort(candidates.begin() , candidates.end(), [](auto a, auto b){return a.size() == b.size() ?  a[0] > b[0] : a.size() > b.size();});
    return candidates[0];
}

int main()
{
    std::println("E1");
    std::println("{}", largest_same_digits("6777133339"));

    std::println("E2");
    std::println("{}", largest_same_digits("1200034"));

    std::println("E3");
    std::println("{}", largest_same_digits("44221155"));

    std::println("E4");
    std::println("{}", largest_same_digits("88888"));

    std::println("E5");
    std::println("{}", largest_same_digits("11122233"));
}
