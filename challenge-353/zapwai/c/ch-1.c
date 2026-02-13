#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void proc(char *s[], int len) {
  printf("Input: \n");
  for (int i = 0; i < len; i++)
    printf("\t%s\n", s[i]);
  int max = 0;

  for (int i = 0; i < len; i++) {
    int cnt = 0;
    char *my_string = malloc(1000);
    strcpy(my_string, s[i]);
    char *tok = strtok(my_string, " ");
    while (tok != NULL) {
      cnt++;
      tok = strtok(NULL, " ");
    }
    if (max < cnt) max = cnt;
  }
  
  printf("Output: %d\n", max);
}

int main() {
  char *s[] = {"Hello world", "This is a test", "Perl is great"};
  proc(s, 3);
  char *s2[] = {"Single"};
  proc(s2, 1);
  char *s3[] = {"Short", "This sentence has seven words in total", "A B C", "Just four words here"};
  proc(s3, 4);
  char *s4[] = {"One", "Two parts", "Three part phrase", ""};
  proc(s4, 4);
  char *s5[] = {"The quick brown fox jumps over the lazy dog", "A", "She sells seashells by the seashore", "To be or not to be that is the question"};
  proc(s5, 4);
}
