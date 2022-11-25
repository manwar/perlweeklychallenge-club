#include<iostream>
#include<vector>
#include<numeric>

int equal_distribution(const std::vector<int>& vec)
{
  int sum{},avg{},moves{},sum_part{};
  sum = std::accumulate(vec.begin(),vec.end(),0);
  if(sum % vec.size() == 0)
  {
    avg = (int)sum / vec.size();
    for(size_t i = 0; i < vec.size(); ++i)
    {
      sum_part += vec[i];
      moves += abs(sum_part - (avg * (i+1)));
    }
    return moves;
  }
  return -1;
}

int main(void)
{
  std::vector<int> vec1{1,0,5};
  std::vector<int> vec2{0,2,0};
  std::vector<int> vec3{0,3,0};
  std::cout << equal_distribution(vec1) << '\n';
  std::cout << equal_distribution(vec2) << '\n';
  std::cout << equal_distribution(vec3) << '\n';
  return 0;
}
