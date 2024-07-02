#include <stdio.h>

void proc(int hours[], int hourslen) {
  printf("Input: { ");
  for (int i = 0; i < hourslen; i++)
    printf("%d ", hours[i]);
  printf("}\n");
  int tally = 0;
  for (int i = 0; i < hourslen - 1; i++) {
    for (int j = i + 1; j < hourslen; j++) {
      int sum = hours[i] + hours[j];
      if (sum % 24 == 0)
	tally++;
    }
  }
  printf("Output: %d\n", tally);
}

int main() {
  int hours[] = {12, 12, 30, 24, 24};
  proc(hours, sizeof(hours)/sizeof(int));
  int hours2[] = {72, 48, 24, 5};
  proc(hours2, sizeof(hours2)/sizeof(int));
  int hours3[] = {12, 18, 24};
  proc(hours3, sizeof(hours3)/sizeof(int));
}
