#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void proc(char*, char*);
int main() {
  char s1[] = "abcd";
  char s2[] = "1234";
  proc(s1, s2);

  char r1[] = "abc";
  char r2[] = "12345";
  proc(r1, r2);

  char q1[] = "abcde";
  char q2[] = "123";
  proc(q1, q2);
}

void proc(char* str1, char* str2) {
  printf("Input: str1 = %s, str2 = %s\n", str1, str2);
  int len1 = strlen(str1);
  int len2 = strlen(str2);  
  char* merged = malloc( sizeof(char) * (1 + len1 + len2) );
  int N = (len1 < len2) ? len1 : len2;
  int i;
  for (i = 0; i < N; i++) {
    merged[2*i] = str1[i];
    merged[2*i + 1] = str2[i];
  }
  if (len1 < len2) {
    for (int s = 2*i; i < len2; s++, i++) {
      merged[s] = str2[i];
    }
  }
  else {
    for (int s = 2*i; i < len1; s++, i++) {
      merged[s] = str1[i];
    }
  }
  printf("Output: %s\n\n", merged);
  free(merged);
}
