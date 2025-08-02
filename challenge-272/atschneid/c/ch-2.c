# include <stdio.h>
# include <string.h> // strlen
# include <stdlib.h> // abs

int sum_abs_char_diffs(const char * s) {
  const size_t s_len = strlen(s);

  int abs_diff, sum = 0;
  for (int i=1; i < s_len; i++) {
    abs_diff = abs(s[i] - s[i-1]);
    sum += abs_diff;
  }
  return sum;
}


int main() {
  char * inputs[] = {
    "hello",
    "perl",
    "raku",
    "c"
  };
  const size_t num_strings = 4;

  for (int i=0; i < num_strings; i++) {
    printf("input : %s, sum : %d\n",
	   inputs[i],
	   sum_abs_char_diffs(inputs[i]));
  }
}
    
    
