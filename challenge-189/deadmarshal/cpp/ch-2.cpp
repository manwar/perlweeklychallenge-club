#include<iostream>
#include<vector>
#include<unordered_map>

void array_degree(const std::vector<int>& vec)
{
  std::unordered_map<int,int> left{},count{};
  std::size_t x{},min{},max{},index{};
  for(std::size_t i = 0; i < vec.size(); ++i)
  {
    x = vec[i];
    if(!count.contains(x))
    {
      left[x] = i;
      count[x] = 1;
    }
    else count[x]++;

    if(count[x] > max)
    {
      max = count[x];
      min = i - left[x] + 1;
      index = left[x];
    }
    else if((count[x] == max) && (i - left[x] + 1 < min))
    {
      min = i - left[x] + 1;
      index = left[x];
    }
  }
  
  for(std::size_t i = index; i < index+min; ++i)
    std::cout << vec[i] << ' ';
  std::cout << '\n';
}

int main()
{
  std::vector<int>
    vec1{1,3,3,2},
    vec2{1,2,1,3},
    vec3{1,3,2,1,2},
    vec4{1,1,2,3,2},
    vec5{2,1,2,1,1};
  array_degree(vec1);
  array_degree(vec2);
  array_degree(vec3);
  array_degree(vec4);
  array_degree(vec5); 
  return 0;
}
