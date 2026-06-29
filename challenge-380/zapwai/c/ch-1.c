#include <stdio.h>
#include <string.h>
#include <stdbool.h>

void proc(char *s) {
  printf("Input: \"%s\"\n", s);
  char letter[26] = {};
  int freq[26] = {};
  int letter_len = 0;
  
  int len = strlen(s);
  for (int i = 0; i < len; i++) {
    char l = s[i];
    // if l is in letter array, we increment. Otherwise we add.
    bool found = false;
    for (int j = 0; j < letter_len; j++) {
      char L = letter[j];
      if (L == l) {
	freq[j]++;
	found = true;
	break;
      }
    }
    if (!found) {
      letter[letter_len] = l;
      freq[letter_len++] = 1;
    }
  }

  int vowel_max = 0, cons_max = 0;
  for (int i = 0; i < letter_len; i++) {
    char l = letter[i];
    if (l == 'a' || l == 'e' || l == 'i' || l == 'o' || l == 'u') {
      if (vowel_max < freq[i]) vowel_max = freq[i];
    } else {
      if (cons_max < freq[i]) cons_max = freq[i];
    }
  }
  printf("Output: %d\n", vowel_max + cons_max);
}

int main() {
  char *s = "banana";
  proc(s);
  s = "teestett";
  proc(s);
  s = "aeiouuaa";
  proc(s);
  s = "rhythm";
  proc(s);
  s = "x";
  proc(s);
}
