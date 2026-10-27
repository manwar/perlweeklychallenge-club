#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int comp(const void *a, const void *b) {
  int *vA = a;
  int *vB = b;
  return *vA - *vB;
}

char *reverse(char *s) {
  int len = strlen(s);
  char *out = malloc(len+1);
  for (int i = len; i >= 0; i--) {
    out[i] = s[len - i - 1];
  }
  out[len] = '\0';
  return out;
}

void proc(int m, int a[m]) {
  printf("Input: ");
  for (int i = 0; i < m; i++)
    printf("%d ", a[i]);
  printf("\n");
  
  qsort(a, m, sizeof(int), comp);
  
  char *b[m];
  char *rb[m];
  for (int i = 0; i < m; i++) {
    b[i] = malloc(20);
    rb[i] = malloc(20);
  }
  
  for (int i = 0; i < m; i++) {
    sprintf(b[i], "%b", a[i]);
    rb[i] = reverse(b[i]);
  }

  for (int i = 0; i < m; i++)
    free(b[i]);
  
  int flag = 1;
  while (flag != 0) {
    flag = 0;
    for (int i = 0; i < m - 1; i++) {
      if (atoi(rb[i]) > atoi(rb[i+1])) {
	flag++;
	char *tmp = rb[i];
	rb[i] = rb[i+1];
	rb[i+1] = tmp;
	int tmp2 = a[i];
	a[i] = a[i+1];
	a[i+1] = tmp2;
      }
    }
  }
  printf("Output: ");
  for (int i = 0; i < m; i++) {
    printf("%d ", a[i]);
    free(rb[i]);
  }
  printf("\n");
}
int main() {
  int a[] = {3, 6, 12};
  proc(sizeof(a)/sizeof(int), a);
  int a2[] = {1,2,4,8};
  proc(sizeof(a2)/sizeof(int), a2);
  int a3[] = {7, 8, 9, 10};
  proc(sizeof(a3)/sizeof(int), a3);
  int a4[] = {5, 9, 15, 17};
  proc(sizeof(a4)/sizeof(int), a4);
  int a5[] = {11, 13, 14, 19};
  proc(sizeof(a5)/sizeof(int), a5);
}
