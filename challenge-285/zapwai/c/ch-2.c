#include <stdio.h>
int tally(int p, int n, int d, int q, int h) { return p + 5*n + 10*d + 25*q + 50*h; }
int main() {
  int amt = 100;
  int cnt = 0;
  for (int h = 0; h <= amt/50; h++)
    for (int q = 0; q <= amt/25; q++)
      for (int d = 0; d <= amt/10; d++)
	for (int n = 0; n <= amt/5; n++)
	  for (int p = 0; p <= amt; p++)
	    if (tally(p, n, d, q, h) == amt)
	      cnt++;
  printf( "There are %d ways to make change for %d cents.\n", cnt, amt);
}

