#include <stdio.h>
#include <string.h>
#include <stdbool.h>

char to_lower(char u) {
  return (u >= 65 && u <= 90) ? u+32 : u;
}

void sort(char c[], int clen) {
  bool flag = false;
  do {
    flag = false;
    for (int i = 0; i < clen - 1; i++) {
      if (c[i] > c[i+1]) {
	char tmp = c[i];
	c[i] = c[i+1];
	c[i+1] = tmp;
	flag = true;
      }
    }
  } while (flag);
}

bool is_upper(char l) {
  return (to_lower(l) != l);
}

char proc(char* str) {
  char* letters = str;
  char upper[26];
  char lower[26];
  int i1 = 0;
  int i2 = 0;
  for (int i = 0; i < strlen(str); i++) {
    char l = str[i];
    if (is_upper(l)) {
      upper[i1] = l;
      i1++;
    }
    else {
      lower[i2] = l;
      i2++;
    }
  }
  char common[26];
  int i3 = 0;
  for (int i = 0; i < i1; i++) {
    char u = upper[i];
    for (int j = 0; j < i2; j++) {
      char l = lower[j];
      if (to_lower(u) == l) {
	common[i3] = u;
	i3++;
      }
    }
  }
  sort(common, i3);
  return common[i3 - 1];
}

int main() {
  char* str = "PeRlwEKLy";
  printf("Input: %s\n", str);
  printf("Output: %c\n", proc(str));
}
