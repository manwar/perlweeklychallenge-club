#include<cstdio>
#include<string>

int main(int argc, char *argv[])
{
  int days[] = {31,29,31,30,31,30,31,31,30,31,30,31};
  int year{}, week{};
  if((argc < 2) || ((year = std::stoi(argv[1])) <= 1752))
  {
    fprintf(stderr, "No arg(s) provided or is less than 1752!");
    return 1;
  }
  days[1] -= (year % 4) || (!(year % 100) && (year % 400));
  week = year * 365 + 97 * (year-1) + 4;

  for(int month{}; month < 12; ++month)
  {
    week = (week + days[month]) % 7;
    printf("%d-%02d-%d\n", year, month+1, days[month] - week);
  }
  
  return 0;
}

