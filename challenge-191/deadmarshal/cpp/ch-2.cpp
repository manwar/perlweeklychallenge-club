#include<iostream>
#include<vector>

bool is_cute(const std::vector<int>& vec)
{
  for(std::size_t i = 1; i <= vec.size(); ++i)
    if((i % vec[i-1]) && (vec[i-1] % i)) return false;
  return true;
}

void permute(std::vector<int>& vec, int i, std::size_t sz, int *count)
{
  if(sz == i)
  {
    if(is_cute(vec)) (*count)++;
    return;
  }
  for(std::size_t j = i; j < sz; ++j)
  {
    std::swap(vec[i], vec[j]);
    permute(vec,i+1,sz,count);
    std::swap(vec[i], vec[j]);
  }
  return;
}

int main()
{
  std::vector<int> vec{1,2};
  int count{};
  permute(vec,0,2,&count);
  std::cout << count << '\n';
  return 0;
}
