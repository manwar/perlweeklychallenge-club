#include<iostream>

bool has_same_digits(int n1, int n2)
{
  int digits[] = {0,0,0,0,0,0,0,0,0,0};
  while(n1){digits[n1 % 10]++; n1 /= 10;}
  while(n2){digits[n2 % 10]--; n2 /= 10;}
  for(int i = 0; i < 10; ++i)
    if(digits[i] != 0) return false;
  return true;
}

int smallest_permuted_multiplies()
{
  int i = 10, found;
  while(true)
  {
    found = 1;
    for(int j = 2; j < 6; ++j)
    {
      if(!has_same_digits(i, i * j))
      {
	found = 0;
	break;
      }
    }
    if(found) return i;
    i++;
  }
}

int main()
{
  std::cout << smallest_permuted_multiplies() << '\n'; 
  return 0;
}
