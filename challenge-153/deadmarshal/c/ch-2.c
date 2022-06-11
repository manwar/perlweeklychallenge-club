#include<stdio.h>
#include<stdlib.h>
#include<errno.h>
#include<limits.h>
#include<string.h>

int factorial(int n)
{
  if(n == 0) return 1;
  else return n * factorial(n-1);
}

int factorions(int n)
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
    fprintf(stderr, "No args provided!\n");
    exit(1);
  }
  char *p;
  errno = 0;
  long arg = strtol(argv[1], &p, 10);
  if(*p != '\0' || errno != 0)
  {
    fprintf(stderr, "Arg[1] should be numeric!");
    exit(1);
  }
  if(arg < INT_MIN || arg > INT_MAX)
  {
    fprintf(stderr, "Underflow or overflow\n");
    exit(1);
  }
  int arg_int = arg;

  printf("%d\n", factorions(arg_int));
  
  return 0;
}
