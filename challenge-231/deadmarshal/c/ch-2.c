#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int senior_citizens(const char **arr,size_t sz)
{
  char s[3];
  int age,count = 0;
  for(size_t i = 0; i < sz; ++i)
  {
    memcpy(&s,arr[i] + strlen(arr[i])-4,2);
    s[2] = '\0';
    age = atoi(s);
    if(age >= 60) count++;
  }
  return count;
}

int main()
{
  const char *arr1[] = {"7868190130M7522",
			"5303914400F9211",
			"9273338290F4010"};
  const char *arr2[] = {"1313579440F2036",
			"2921522980M5644"};
  size_t sz1 = 3,sz2 = 2;
  printf("%d\n",senior_citizens(arr1,sz1));
  printf("%d\n",senior_citizens(arr2,sz2));
  return 0;
}

