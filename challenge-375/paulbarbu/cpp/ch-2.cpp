#include <print>
#include <ranges>
#include <string_view>
#include <vector>
#include <cmath>

auto find_k_beauty(int n, unsigned int k)
{
    if(n<0) // make it do somethign with negatives as well
    {
        n *= -1;
    }

    const int initial = n;
    int c=0;
    const int pexp = std::pow(10, k-1);
    while(n / pexp >= 1) // divide n until we have k digits left
    {
        int x = n % 10; // my candidate "beauty"
        n /= 10;
        for(int i =1; i<k; i++) // construct the k-length substrings beauties
        {
            x = (n%10) * std::pow(10, i) + x;
        }

        if(initial % x == 0) // divisible, so count the beauty
        {
            c++;
        }
    }

    return c;
}

int main()
{
    std::println("E1");
    std::println("{}", find_k_beauty(240, 2));

    std::println("E2");
    std::println("{}", find_k_beauty(1020, 2));

    std::println("E3");
    std::println("{}", find_k_beauty(444, 2));

    std::println("E4");
    std::println("{}", find_k_beauty(17, 2));

    std::println("E5");
    std::println("{}", find_k_beauty(123, 1));

    std::println("Extra6");
    std::println("{}", find_k_beauty(1, 2));

    std::println("Extra7");
    std::println("{}", find_k_beauty(1, 1));

    std::println("Extra8");
    std::println("{}", find_k_beauty(1, 0));
    
    std::println("Extra9");
    std::println("{}", find_k_beauty(-240, 2));

    std::println("Extra10");
    std::println("{}", find_k_beauty(-1020, 2));

    std::println("Extra11");
    std::println("{}", find_k_beauty(-444, 2));

    std::println("Extra12");
    std::println("{}", find_k_beauty(-17, 2));

    std::println("Extra13");
    std::println("{}", find_k_beauty(-123, 1));

    std::println("Extra14");
    std::println("{}", find_k_beauty(-1, 2));

    std::println("Extra15");
    std::println("{}", find_k_beauty(-1, 1));

    std::println("Extra16");
    std::println("{}", find_k_beauty(-1, 0));

    std::println("Extra17");
    std::println("{}", find_k_beauty(0, 0));
}
