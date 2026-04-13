#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>

void proc(char *caption) {
  printf("Input: %s\n", caption);
  int len = strlen(caption);
  char buffer[100];
  int blen = 0;
  bool wordflag = false;
  int start = 0;
  for (int i = 0; i < len; i++) {
    if (caption[i] != ' ') {
      start = i;
      break;
    }
  }
    
  for (int i = start; i < len; i++) {
    if (blen == 99) break;
    if (isalpha(caption[i])) {
      if (wordflag) {
	buffer[blen++] = toupper(caption[i]);
	wordflag = false;
      } else {
	buffer[blen++] = tolower(caption[i]);
      }
    } else if (caption[i] == ' ') {
      wordflag = true;
    }
  }
  buffer[blen] = '\0';
  printf("Output: #%s\n", buffer);
}

int main() {
  char *caption = "Cooking with 5 ingredients!";
  proc(caption);
  caption = "the-last-of-the-mohicans";
  proc(caption);
  caption = "  extra spaces here";
  proc(caption);
  caption = "iPhone 15 Pro Max Review";
  proc(caption);
  caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!";
  proc(caption);
}
