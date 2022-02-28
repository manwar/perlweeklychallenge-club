#include<iostream>
#include<string>
#include<sstream>
#include<cstring>

int factorial(int n)
{
  if(n == 0) return 1;
  else return n * factorial(n-1);
}

bool factorions(int n)
{
  unsigned sum = 0;
  int copy = n;
  do{
    sum += factorial(copy % 10);
    copy /= 10;
  }while(copy != 0);
  
  return sum == n;
}

int main(int argc, char *argv[])
{
  if(!argv[1] || strlen(argv[1]) == 0)
  {
    std::cerr << "No args provided!\n";
    exit(1);
  }
  
  std::stringstream ss(argv[1]);
  int num;
  if(!(ss >> num))
  {
    std::cout << "error converting number!\n";
    exit(1);
  }
  
  std::cout << std::boolalpha << factorions(num) << ' ';
  std::cout << '\n';
  
  return 0;
}
