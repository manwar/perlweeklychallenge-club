#include <stdio.h>
#include <string.h>

void proc(char mystr[]) {
  printf("Input: %s\n", mystr);
  int cnt = 0;
  char* word;
  word = strtok(mystr, "|");
  int j = 0;
  while (word != NULL) {
    if (j % 2 == 0)
      for (int i = 0; i < strlen(word); i++)
	if (word[i] == '*')
	  cnt++;
    word = strtok(NULL, "|");
    j++;
  }
  printf("Output: %d\n", cnt);
}

int main() {
  char mystr[] = "p|*e*rl|w**e|*ekly|";
  proc(mystr);
  char mystr2[] = "perl";
  proc(mystr2);
  char mystr3[] = "th|ewe|e**|k|l***ych|alleng|e";
  proc(mystr3);
}

