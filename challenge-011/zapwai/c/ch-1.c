#include <stdio.h>

float f(int c) {
  float m = (212-32)/100.;
  return (32 + m*c);
}

void proc() {
  for (int i = -100; i < 212; i++)
    if (f(i) == i)
      printf("Eq pt: %.2f deg Celsius (or Fahrenheit!)\n", f(i));
}

int main() {
  proc();
}

