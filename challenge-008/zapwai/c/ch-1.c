#include <stdio.h>
#include <math.h>

int is_perfect(int num) {
  int sum = 0;
  for (int i = 1; i < 1 + (int) num/2; i++) 
    if (num % i == 0)
      sum += i;
  return (sum == num);
}

void perfects() {
  for (int p = 2; p < 15; p++) {
    int num = pow(2, p-1) * (pow(2,p) - 1);
    if (is_perfect(num)) printf("%d ", num);
  }
  printf("\n");
}

int main() {
  perfects();
}
