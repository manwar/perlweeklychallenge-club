//https://godbolt.org/z/qWfTha4qx
//--std=c++23
#include <print>
#include <algorithm>
#include <ranges>
#include <unordered_set>

auto vowels(std::string str)
{
    for(int s=0; s<=str.length()-5; s++)
    {
        // std::println("hi");
        std::string seen = "";
        seen.reserve(5);
        std::array<bool, 5> presence = {false, false, false, false, false};
        int last_found = s-1;
        for(int e=s; e<str.length() && e-last_found==1; e++)
        {
            bool found_one_now = false;
            if(str[e] == 'a')
            {
                //vowel
                seen.push_back(str[e]);
                presence[0] = found_one_now = true;
                last_found = e;
            }
            else if (str[e] == 'e')
            {
                //vowel
                seen.push_back(str[e]);
                presence[1] = found_one_now = true;
                last_found = e;
            }
            else if (str[e] == 'i')
            {
                //vowel
                seen.push_back(str[e]);
                presence[2] = found_one_now = true;
                last_found = e;
            }
            else if (str[e] == 'o')
            {
                //vowel
                seen.push_back(str[e]);
                presence[3] = found_one_now = true;
                last_found = e;
            }
            else if (str[e] == 'u')
            {
                //vowel
                seen.push_back(str[e]);
                presence[4] = found_one_now = true;
                last_found = e;
            }

            if(found_one_now && std::all_of(presence.cbegin(), presence.cend(), [](bool b){return b;}))
            {
                std::println("{}", seen);
            }
        }   
    }
}


auto ranges_vowels(std::string str)
{
    for(auto i : std::views::iota(5U, 1U + str.size()))
    {   
        for (auto r : str | std::views::slide(i) )
        {
            std::unordered_set<char> set;
            const std::unordered_set<char> vowels = {'a', 'e', 'i', 'o', 'u'};
            set.reserve(5);
            set.insert_range(r);
            if(set == vowels)
            {
                std::println("{}", std::string_view(r));
            }
        }
    }
}

int main()
{
    std::println("1");
    ranges_vowels("aeiou");
    std::println("2");
    ranges_vowels("aaeeeiioouu");
    std::println("3");
    ranges_vowels("aeiouuaxaeiou");
    std::println("4");
    ranges_vowels("uaeiou");
    std::println("5");
    ranges_vowels("aeioaeioa");

    std::println("-------------------");
    
    std::println("1");
    vowels("aeiou");
    std::println("2");
    vowels("aaeeeiioouu");
    std::println("3");
    vowels("aeiouuaxaeiou");
    std::println("4");
    vowels("uaeiou");
    std::println("5");
    vowels("aeioaeioa");
    // std::println();
}
