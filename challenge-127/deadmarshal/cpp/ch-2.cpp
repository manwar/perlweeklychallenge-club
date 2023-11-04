#include<iostream>
#include<vector>

struct Interval
{ 
  friend std::ostream &operator<<(std::ostream &os,
				  const Interval &interval)
  {
    os << '(' << interval.x << ',' << interval.y << ')';
    return os;
  }

  int x,y;
};

template<typename T>
void conflict_intervals(const std::vector<T> &vec)
{
  for(size_t i = 1; i < vec.size(); ++i)
  {
    bool b = false;
    for(size_t j = 0; j < i ; ++j)
      if((vec.at(i).x >= vec.at(i).x) && (vec.at(i).x <= vec.at(j).y)) b = true;
    if(b) std::cout << vec.at(i) << ' ';
  }
  std::cout << '\n';
}

int main()
{
  std::vector<Interval> vec1{{1,4},{3,5},{6,8},{12,13},{3,20}};
  std::vector<Interval> vec2{{3,4},{5,7},{6,9},{10,12},{13,15}};
  conflict_intervals<Interval>(vec1);
  conflict_intervals<Interval>(vec2);
  return 0;
}

