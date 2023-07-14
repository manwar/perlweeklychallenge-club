#include<stdio.h>
#include<ctype.h>

size_t max_words(const char **arr, size_t sz)
{
  size_t count = 0, max = 0;
  for(size_t i = 0; i < sz; ++i)
  {
    for(size_t j = 0; arr[i][j] != '\0'; ++j)
      if(isspace(arr[i][j])) count++;
    if(max < count) max = count;
    count = 0;
  }
  return max+1;
}

int main(int argc, char **argv)
{
  const char *arr1[] = {"Perl and Raku belong to the same family.",
			"I love perl.",
		  "The Perl and Raku Conference."};
  const char *arr2[] = {"The Weekly Challenge.",
			"Python is the most popular guest language.",
		  "Team PWC has over 300 members."};
  const size_t sz = 3;
  printf("%zu\n",max_words(arr1,sz));
  printf("%zu\n",max_words(arr2,sz));
  return 0;
}

