#include <stdio.h>
#include <stdlib.h>

void proc(int num[], int len) {
  printf("Input: ( ");
  for (int i = 0; i < len; i++)
    printf("%d ", num[i]);
  printf(")\n");
  int min_diff = abs(num[1] - num[0]);
  for (int i = 0; i < len-1; i++) {
    int x = abs(num[i+1] - num[i]);
    if (min_diff > x)
      min_diff = x;
  }

  char outs[100][20];
  int outs_cnt = 0;
  for (int i = 0; i < len-1; i++) {
    for (int j = i+1; j < len; j++) {
      int x = abs(num[j] - num[i]);
      if (x == min_diff) {
	snprintf(outs[outs_cnt++], 20, "[%d, %d]", num[i], num[j]);
      }
    }
  }

  printf("Output: ");
  for (int i = 0; i < outs_cnt; i++)
    printf("%s ", outs[i]);
  printf("\n");
}

int main() {
  int num[] = {4,2,1,3};
  int len = sizeof(num) / sizeof(int);
  proc(num, len);

  int num2[] = {10, 100, 20, 30};
  len = sizeof(num2) / sizeof(int);
  proc(num2, len);
}
