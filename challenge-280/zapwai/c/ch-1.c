#include <stdio.h>
#include "vec.h"

void proc(char* mystr) {
  printf( "Input: %s\n", mystr);
  char letter = '0';
  vec *gotten = new_vec('c');
  for (int i = 0; i < strlen(mystr); i++) {
    char l = mystr[i];
    if (gotten->size > 0) {
      for (int j = 0; j < gotten->size; j++) {
	char g = gotten->datac[j];
	if (l == g)
	  letter = l;
      }
    }
    if (letter != '0') {
      break;
    } else {
      push(gotten, (char[]){l});
    }
  }
  printf( "Output: %c\n", letter);
}

int main() {
  char* mystr = "abcddbca";
  proc(mystr);
  char* mystr2 = "abcd";
  proc(mystr2);
  char* mystr3 = "abcdabbb";
  proc(mystr3);
}

