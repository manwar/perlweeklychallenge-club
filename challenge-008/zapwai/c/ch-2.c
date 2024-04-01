#include <stdio.h>
#include <string.h>

int max(int len, int nums[]) {
  int max = 0;
  for (int i = 0; i < len; i++) {
    if (max < nums[i])
      max = nums[i];
  }
  return max;
}

void center(int wordlen, char* words[]) {
  int lens[wordlen];
  for (int i = 0; i < wordlen; i++) {
    lens[i] = strlen(words[i]);
  }
  int M = max(wordlen, lens);
  for (int i = 0; i < wordlen; i++){
    for (int j = 0; j < M - lens[i]; j++)
      if (j % 2 == 0)
	printf(" ");
    printf("%s\n", words[i]);
  }
}

int main() {
  char* l[] = {"This", "is", "a test of the", "center function"};
  int len = sizeof(l) / sizeof(char*);
  center(len, l);
}
