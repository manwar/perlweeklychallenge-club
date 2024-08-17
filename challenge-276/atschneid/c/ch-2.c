#include <stdio.h>
#include <stdlib.h> // qsort

int cf_func(const void* a, const void* b) {
  return *(const int*)a > *(const int*)b ? -1 : 1;
}

int max_freq_count( int list[], int length ) {
  qsort( list, length, sizeof( int ), cf_func );

  int j = 0;
  int current = list[0];
  list[0] = 1;

  for (int i=1; i < length; i++) {
    if (list[i] == current) {
      list[j]++;
    } else {
      current = list[i];
      list[++j] = 1;
    }
  }

  qsort( list, ++j, sizeof( int ), cf_func );

  int max = list[0];
  int sum = max;
  for (int i=1; i <= j; i++) {
    if (list[i] == max ) {
      sum += max;
    } else {
      break;
    }
  }

  return sum;
}

int main() {
  int const num_inputs = 2;
  // hack again where index 0 is the length
  // and real array starts at index 1
  int inputs[num_inputs][7] = {
    {6, 1, 2, 2, 4, 1, 5},
    {5, 1, 2, 3, 4, 5}
  };
  for (int i=0; i < num_inputs; i++) {
    int maxs = max_freq_count( &inputs[i][1], inputs[i][0] );
    printf( "input: %d %d\n", i, maxs );
  }
}

    
