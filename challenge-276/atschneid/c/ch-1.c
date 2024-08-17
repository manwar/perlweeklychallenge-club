#include <stdio.h>

int count_completed_days_v1( int list[], int length ) {
  int day_count[24] = {0};
  for (int i=0; i < length; i++) {
    day_count[list[i] % 24]++;
  }
  
  int count = day_count[0] * (day_count[0] - 1) / 2;
  count += day_count[12] * (day_count[12] - 1) / 2;
  for (int i=1; i < 12; i++) {
    count += day_count[i] * day_count[24-i];
  }
  return count;
}

int count_completed_days( int list[], int length ) {
  int count = 0;
  int day_count[24] = {0};
  for (int i=0; i < length; i++) {
    count += day_count[(24 - list[i] % 24) % 24];
    day_count[list[i] % 24]++;
  }
  return count;
}

int main() {
  int const num_inputs = 4;
  // a hack: the first value is the length of the array
  // the following vals are ther actual array
  int inputs[num_inputs][14] = {
    {5, 12, 12, 30, 24, 24},
    {4, 72, 48, 24, 5},
    {3, 12, 18, 24},
    {13, 36, 36, 36, 1, 1, 1, 1, 1, 1, 47, 47, 47, 47}
  };
  for (int i=0; i < num_inputs; i++) {
    // the real array starts at inputs[i][1] because of the hack
    int count = count_completed_days( &inputs[i][1], inputs[i][0] );
    printf( "input: %i :: %d\n", i, count );
  }
}
