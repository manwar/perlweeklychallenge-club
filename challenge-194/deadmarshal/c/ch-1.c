#include<stdio.h>
#include<stdlib.h>

short digital_clock(const char *str)
{
  return str[0] == '?' ? (str[1] - '0' < 4 ? 2 : 1)
    : str[1] == '?' ? (str[0] - '0' < 2 ? 9 : 3)
    : str[3] == '?' ? 5 : 9;
}

int main(void)
{
  printf("%d\n", digital_clock("?5:00"));
  printf("%d\n", digital_clock("?3:00"));
  printf("%d\n", digital_clock("1?:00"));
  printf("%d\n", digital_clock("2?:00"));
  printf("%d\n", digital_clock("12:?5"));
  printf("%d\n", digital_clock("12:5?"));
  return 0;
}
	 
