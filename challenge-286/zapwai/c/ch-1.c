#include <time.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
int main() {
  FILE *fp;
  fp = fopen("ch-1.c", "r");
  if (fp == NULL) {
    printf("cannot open file.");
    exit(1);
  }
  char words[100][100];
  int wordslen = 0;
  char line[100];
  while (fgets(line, sizeof(line), fp)) {
    char *p = strtok(line, " ");
    while(p != NULL) {
      strcpy(words[wordslen++], p);
      p = strtok(NULL, " ");
    }
  }
  fclose(fp);
  srand(time(NULL));
  int num = rand() % wordslen;
  char *word = words[num];
  printf("%s\n", word);
}
