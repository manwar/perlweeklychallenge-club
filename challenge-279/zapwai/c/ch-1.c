#include <stdio.h>

void proc(char l[], int w[], int llen) {
  printf("Input: letters = ");
  for (int i = 0; i < llen; i++)
    printf("%c ", l[i]);
  printf(", weights = ");
  for (int i = 0; i < llen; i++)
    printf("%d ", w[i]);
  printf("\n");
  char ans[llen];
  for (int i = 0; i < llen; i++)
    ans[w[i] - 1] = l[i];
  printf("Output: ");
  for (int i = 0; i < llen; i++)
    printf("%c", ans[i]);
  printf("\n");
}

int main() {
  char letters[] = {'R', 'E', 'P', 'L'};
  int weights[] = {3, 2, 1, 4};
  proc(letters, weights, sizeof(letters) / sizeof(char));
  char letters2[] = {'A', 'U', 'R', 'K'};
  int weights2[] = {2, 4, 1, 3};
  proc(letters2, weights2, sizeof(letters2) / sizeof(char));
  char letters3[] = {'O', 'H', 'Y', 'N', 'P', 'T'};
  int weights3[] = {5, 4, 2, 6, 1, 3};
  proc(letters3, weights3, sizeof(letters3) / sizeof(char));
}
