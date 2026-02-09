#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

int proc(char str[]) {
  for (int i = 0; i < strlen(str); i++) {
    str[i] = tolower(str[i]);
  }
  char *tok = strtok(str, " ");
  char *list[100];		/* at most 100 words */
  
  int I = 0;
  while (tok != NULL) {
    list[I] = malloc(20);	/* max length of word is 20 */
    strcpy(list[I++], tok);
    tok = strtok(NULL, " ");
  }
  printf("Input: ");
  for (int i = 0; i < I; i++) {
    printf("%s ", list[i]);
  }
  printf("\n");

  int cnt = 0;
  do {
    cnt = 0;
    for (int i = 0; i < I - 1; i++) {
      if (strcmp(list[i], list[i+1]) > 0) {
	cnt++;
	char *tmp = malloc(20);
	strcpy(tmp, list[i]);
	strcpy(list[i], list[i+1]);
	strcpy(list[i+1], tmp);
	free(tmp);
      }
    }
  } while(cnt != 0);
  printf("Output: ");
  for (int i = 0; i < I; i++) {
    printf("%s ", list[i]);
  }
  printf("\n");
  return 0;
}

int main() {
  char str[] = "The quick brown fox";
  proc(str);
  char str2[] = "I have 2 apples and 3 bananas!";
  proc(str2);
  char str3[] = "Hello, World! How are you?";
  proc(str3);
  char str4[] = "Hello    World!   How   are you?";
  proc(str4);
}
