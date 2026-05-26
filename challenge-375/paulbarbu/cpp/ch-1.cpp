#include <print>
#include <ranges>
#include <string_view>
#include <vector>

consteval auto single_common_words(const std::vector<std::string> &a, const std::vector<std::string> &b)
{
    int c = 0;
    
    for(const auto& el : a)
    {
        if(std::count(a.cbegin(), a.cend(), el) == 1 && std::count(b.cbegin(), b.cend(), el) == 1)
        {
            c++;
        }
    }

    return c;
}

int main()
{
    
    std::println("E1");
    std::println("{}", single_common_words({"apple", "banana", "cherry"}, {"banana", "cherry", "date"}));

    std::println("E2");
    std::println("{}", single_common_words({"a", "ab", "abc"}, {"a", "a", "ab", "abc"}));

    std::println("E3");
    std::println("{}", single_common_words({"orange", "lemon"}, {"grape", "melon"}));

    std::println("E4");
    std::println("{}", single_common_words({"test", "test", "demo"}, {"test", "demo", "demo"}));

    std::println("E5");
    std::println("{}", single_common_words({"Hello", "world"}, {"hello", "world"}));
}
