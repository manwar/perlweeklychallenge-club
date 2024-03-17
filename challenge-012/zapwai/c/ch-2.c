#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void proc(char* input) {
  char* cp = strdup(input);
  char* line = strtok(cp, "\n");
  char prefix[100] = {};
  strcpy(prefix, line);
  int cnt = 0;
  do {
    cnt = 0;
    do {
      int slen = strlen(prefix);
      prefix[slen - 1] = '\0';
    } while (prefix[strlen(prefix) - 1] != '/');
    while (line != NULL) {
      for (int i = 0; i < strlen(prefix); i++)
	if (prefix[i] != line[i])
	  cnt++;
      line = strtok(NULL, "\n");
    }
  } while (cnt > 0);
  free(cp);
  printf("%s\n", prefix);
}

int main() {
  char* s = "/a/b/c/d\n"
    "/a/b/cd\n"
    "/a/b/cc\n"
    "/a/b/c/d/e\n";
  proc(s);
}
