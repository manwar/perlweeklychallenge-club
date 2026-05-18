#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

// Do we contain a non-vowel?
bool non_vowel(char *word) {
  int len = strlen(word);
  char *alph = "bcdfghjklmnpqrstvwxyz";
  for (int i = 0; i < len; i++) {
    for (int j = 0; j < 21; j++) {
      if (word[i] == alph[j])
	return true;
    }
  }
  return false;
}

// Do we contain all five vowels?
bool all_vowels_check(char *word) {
  int alph[5] = {0}; // boolean, aeiou
  int len = strlen(word);
  for (int i = 0; i < len; i++) {
    switch(word[i]) {
    case 'a':
      alph[0] = 1;
      break;
    case 'e':
      alph[1] = 1;
      break;
    case 'i':
      alph[2] = 1;
      break;
    case 'o':
      alph[3] = 1;
      break;
    case 'u':
      alph[4] = 1;
      break;
    }
  }
  int sum = 0;
  for (int i = 0; i < 5; i++)
    sum += alph[i];
  return (sum == 5);
}

// Return -1 for non-vowel,
// Return 1 for all five vowels,
// Return 0 if not finished.
int finished(char *word) {
  if (non_vowel(word)) {
    return -1;
  } else if (all_vowels_check(word)) {
    return 1;
  }
  return 0;
}

char *subvowel(int i, char *input) {
  int input_len = strlen(input);
  char *word = malloc(20);
  char inp[2];
  inp[0] = input[i];
  inp[1] = '\0';
  strcpy(word, inp);
  bool flag = false;
  for (int j = i; j < input_len - 1; j++) {
    int fin = finished(word);
    if (fin == 1) {
      return word;
    } else if (fin == -1) {
      return "no";
    }
    if (!flag) {
      if (input[j+1] == input[i]) {
	return "no";
      } else {
	inp[0] = input[j+1];
	strcat(word, inp);
	flag = true;
	continue;
      }
    }
    inp[0] = input[j+1];
    strcat(word, inp);
  }
  if (finished(word) == 1) {
    return word;
  } else {
    return "no";
  }
}

void proc(char *input) {
  printf("Input: %s\n", input);
  int len = strlen(input);
  char *list[20];
  int listlen = 0;
  for (int i = 0; i < len - 4; i++) {
    char *word = subvowel(i, input);
    if (strcmp(word,"no") != 0) {
      list[listlen++] = word;
    }
  }
  printf("Output: ");
  for (int i = 0; i < listlen; i++)
    printf("%s ", list[i]);
  printf("\n");
}

int main() {
  char *input = "aeiou";
  proc(input);
  input = "aaeeeiioouu";
  proc(input);
  input = "aeiouuaxaeiou";
  proc(input);
  input = "uaeiou";
  proc(input);
  input = "aeioaeioa";
  proc(input);
}
