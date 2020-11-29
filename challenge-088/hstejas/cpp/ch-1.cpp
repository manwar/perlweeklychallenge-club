#include<iostream>
#include<algorithm>
#include<vector>

std::ostream& operator<<(std::ostream& out, const std::vector<int>& in)
{
    if(in.empty())
        return out;

    out << in[0];
    for(size_t i = 1; i < in.size(); i++)
        out << ", " << in[i];

    return out;
}

std::vector<int> arrayOfProduct(const std::vector<int>& arr)
{
    int product = 1;
    for(const int& n : arr)
        product *= n;

    std::vector<int> ret(arr.size(), product);

    for(size_t i = 0; i < arr.size(); i++)
        ret[i] /= arr[i];

    return ret;
}

int main()
{
    std::cout << arrayOfProduct({5, 2, 1, 4, 3}) << std::endl;
    std::cout << arrayOfProduct({2, 1, 4, 3}) << std::endl;
}