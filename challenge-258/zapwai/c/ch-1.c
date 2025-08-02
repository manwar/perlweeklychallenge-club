#include <stdio.h>
#include <string.h>

void proc(int intslen, int ints[]) {
  printf("Input: { ");
  for (int i = 0; i < intslen; i++) {
    printf("%d ", ints[i]);
  }
  printf("}\n");
  int cnt = 0;
  for (int i = 0; i < intslen; i++) {
    char word[50];
    sprintf(word, "%d", ints[i]);
    if (strlen(word) % 2== 0) {
      cnt++;
    }
  }
  printf("Output: %d\n", cnt);
}

int main() {
  int ints[] = {10, 1, 111, 24, 1000};
  proc(sizeof(ints)/sizeof(int), ints);
  int ints2[] = {111, 1, 11111};
  proc(sizeof(ints2)/sizeof(int), ints2);
  int ints3[] = {2, 8, 1024, 256};
  proc(sizeof(ints3)/sizeof(int), ints3);

}

