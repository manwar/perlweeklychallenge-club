#include <stdio.h>
#include <string.h>

void proc(char sentence[], char keys[], int keyslen) {
  printf("Input: Sentence = %s, Keys = ", sentence);
  for (int i = 0; i < keyslen; i++)
    printf("%c ", keys[i]);
  printf("\n");
  int num = 0;
  char* token = strtok(sentence, " ");
  while (token != NULL) {
    int tally = 0;
    for (int k = 0; k < keyslen; k++) {
      if (strchr(token, keys[k]) != NULL) {
	break;
      } else {
	tally++;
      }
    }
    if (tally == keyslen)
      num++;
    token = strtok(NULL, " ");
  }
  printf("Output: %d\n", num);
}
    
int main(){
  char sentence[] = "Perl Weekly Challenge";
  char keys[] = {'l', 'a'};
  proc(sentence, keys, sizeof(keys) / sizeof(char));
  char sentence2[] = "Perl and Raku";
  char keys2[] = {'a'};
  proc(sentence2, keys2, sizeof(keys2) / sizeof(char));
  char sentence3[] = "Well done Team PWC";
  char keys3[] = {'l', 'o'};
  proc(sentence3, keys3, sizeof(keys3) / sizeof(char));
}
