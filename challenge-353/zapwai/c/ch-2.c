#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>
#include <string.h>

void proc(int N, char **codes, char **names, bool status[]) {
  printf("Input: \n");
  printf(" Codes: ");
  for (int i = 0; i < N; i++)
    printf("%s ", codes[i]);
  printf("\n");
  printf(" Names: ");
  for (int i = 0; i < N; i++)
    printf("%s ", names[i]);
  printf("\n");
  printf(" Status: ");
  for (int i = 0; i < N; i++)
    printf("%s ", status[i] ? "true" : "false");
  printf("\n");
  char *cat[] = {"electronics", "grocery", "pharmacy", "restaurant"};
  bool out[N] = {};
  for (int i = 0; i < N; i++) {
    if (!status[i]) {
      out[i] = false;
      continue;
    }
    bool category = false;
    for (int j = 0; j < 4; j++) {
      if (strcmp(cat[j], names[i]) == 0)
	category = true;
    }
    if (!category) {
      out[i] = false;
      continue;
    }
    char *code = codes[i];
    int len = strlen(code);
    bool valid = true;
    for (int j = 0; j < len; j++) {
      if (!(code[j] == '_' || isalpha(code[j]) || isdigit(code[j]))) {
	valid = false;
	break;
      }
    }

    out[i] = valid;
  }
  printf("Output: ");
  for (int i = 0; i < N; i++)
    printf("%s ", out[i] ? "true" : "false");
  printf("\n");

}

int main() {
  char *codes[] = {"A123", "B_456", "C789", "D@1", "E123"};
  char *names[] = {"electronics", "restaurant", "electronics", "pharmacy", "grocery"};
  bool status[] = {true, false, true, true, true};
  int N = 5;
  proc(N, codes, names, status);
  
}
