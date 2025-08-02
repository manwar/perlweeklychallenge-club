#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#define MAX 100

void proc(char* line1, char* line2) {
  char* words[MAX];
  int level = 0;
  char* l1 = strdup(line1);
  char* token = strtok(l1, " ");
  while (token != NULL) {
    words[level] = malloc(50*sizeof(char));
    strcpy(words[level], token);
    level++;
    token = strtok(NULL, " ");
  }
  char* l2 = strdup(line2);
  char* token2 = strtok(l2, " ");
  while (token2 != NULL) {
    words[level] = malloc(50*sizeof(char));
    strcpy(words[level], token2);
    level++;
    token2 = strtok(NULL, " ");
  }
  
  char* sorted[level];
  for (int i = 0; i < level; i++) {
    sorted[i] = malloc(50*sizeof(char));
    strcpy(sorted[i], words[i]);
  }
  int cnt = 0;
  do {
    cnt = 0;
    for (int i = 0; i < level - 1; i++) {
      if (strcmp(sorted[i+1], sorted[i]) > 0) {
	char* word = sorted[i+1];
	sorted[i+1] = sorted[i];
	sorted[i] = word;
	cnt++;
      }
    }
  } while (cnt != 0);
  
  bool match_flag = false;
  char* ans[MAX] = {};
  int ans_len = 0;
  for (int i = 0; i < level - 1; i++) {
    if (match_flag) {
      if (0 != strcmp(sorted[i], sorted[i+1])) {
	match_flag = false;
      }
      continue;
    }
    if (0 == strcmp(sorted[i], sorted[i+1])) {
      match_flag = true;
      continue;
    }
    ans[ans_len] = malloc(50*sizeof(char));
    strcpy(ans[ans_len], sorted[i]);
    ans_len++;
  }
  if (!match_flag) {
    strcpy(ans[ans_len], sorted[level-1]);
    ans_len++;
  }
  for (int i = 0; i < level; i++) {
    free(words[i]);
    free(sorted[i]);
  }
  printf("Input: line1 = %s, line2 = %s\n", line1, line2);
  printf("Output: { ");
  for (int i = 0; i < ans_len; i++) {
    printf("%s ", ans[i]);
    free(ans[i]);
  }
  printf("}\n");
}

int main() {
  char* line1 = "Mango is sweet";
  char* line2 = "Mango is sour";
  proc(line1, line2);

  line1 = "Mango Mango";
  line2 = "Orange";
  proc(line1, line2);

  line1 = "Mango is Mango";
  line2 = "Orange is Orange";
  proc(line1, line2);
}

