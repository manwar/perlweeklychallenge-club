#include <stdio.h>
#define MAX 50

void print_input(int items1[][2], int items2[][2], int len1, int len2) {
  printf("Input: items1 = { ");
  for (int i = 0; i < len1; i++)
    printf("(%d, %d) ", items1[i][0],items1[i][1]);
  printf("}, items2 = { ");
  for (int i = 0; i < len2; i++)
    printf("(%d, %d) ", items2[i][0], items2[i][1]);
  printf("}\n");
}

void print_output(int k[], int v[], int len) {
  printf("Output: ");
  for (int i = 0; i < len; i++)
    printf("(%d, %d) ", k[i], v[i]);
  printf("\n");
}

void proc(int items1[][2], int items2[][2], int len1, int len2) {
  print_input(items1, items2, len1, len2);
  int k[MAX] = {};
  int v[MAX] = {};
  int len = 0;
  for (int i = 0; i < len1; i++) {
    int present_index = -1;
    for (int j = 0; j < len; j++)
      if (k[j] == items1[i][0]) 
	present_index = j;
    if (present_index == -1) {
      k[len] = items1[i][0];
      v[len] = items1[i][1];
      len++;
    } else {
      v[present_index] += items1[i][1];
    }
  }
  for (int i = 0; i < len2; i++) {
    int present_index = -1;
    for (int j = 0; j < len; j++)
      if (k[j] == items2[i][0])
	present_index = j;
    if (present_index == -1) {
      k[len] = items2[i][0];
      v[len] = items2[i][1];
      len++;
    } else {
      v[present_index] += items2[i][1];
    }
  }
  print_output(k, v, len);
}

int main() {
  int items1c[3][2] = { {1,1}, {2,1}, {3,2} };
  int items2c[2][2] = { {2,2}, {1,3} };
  int items1a[4][2] = { {1,2}, {2,3}, {1,3}, {3,2} };
  int items2a[2][2] = { {3,1}, {1,3} };
  int items1b[3][2] = { {1,1}, {2,2}, {3,3} };
  int items2b[2][2] = { {2,3}, {2,4} };
  proc(items1c, items2c, 3, 2);
  proc(items1a, items2a, 4, 2);
  proc(items1b, items2b, 3, 2);
}
