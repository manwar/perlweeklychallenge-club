#include <stdio.h>
#include <string.h>
#include <stdbool.h>

void proc(char *s, int M, char *array[M]) {
  printf("Input: str = %s\n", s);
  int cnt = 0;
  for (int i = 0; i < M; i++) {
    printf("%s ", array[i]);
    char *word = array[i];
    int len = strlen(word);
    bool good = true;
    for (int j = 0; j < len; j++)
      if (word[j] != s[j]) good = false;
    if (good) cnt++;
  }
  printf("\n");
  printf("Output: %d\n", cnt);
}

int main() {
  char *array[5] = {"a", "ap", "app", "apple", "banana"};
  char *s = "apple";
  proc(s, 5, array);

  char *array2[3] = {"cat", "dog", "fish"};
  s = "bird";
  proc(s, 3, array2);
  
  char *array3[] = {"hello", "he", "hell", "heaven", "he"};
  s = "hello";
  proc(s, 5, array3);
  
  char *array4[] = {"", "code", "coding", "cod"};
  s = "coding";
  proc(s, 4, array4);
  
  char *array5[] = {"p", "pr", "pro", "prog", "progr", "progra", "program"};
  s = "program";
  proc(s, 7, array5);

}
