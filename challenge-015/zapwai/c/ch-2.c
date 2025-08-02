#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define max_len 100

char* vigenere(int mode, char* the_key, int the_key_len, char* msg, int msg_len) {
  char* alph = "abcdefghijklmnopqrstuvwxyz";
  msg_len--; the_key_len--;
  int q = msg_len / the_key_len;
  char key[max_len];
  int key_len = 0;
  while (q > 0) {
    strcat(key, the_key);
    q--;
    key_len += the_key_len;
  }
  int j = 0;
  while (key_len < msg_len) {
    key[key_len] = the_key[j];
    key[key_len + 1] = '\0';
    key_len++;
    j++;
  }
  int rots[max_len] = {};
  for (int i = 0; i < key_len; i++) {
    char* e;
    e = strchr(alph, key[i]);
    rots[i] = (int)(e - alph);
  }

  char* ans_letters = malloc(max_len * sizeof(char));
  for (int i = 0; i < msg_len; i++) {
    if (!isalpha(msg[i])) {
      ans_letters[i] = msg[i];
      continue;
    }
    char* e;
    e = strchr(alph, msg[i]);
    int v = (int)(e - alph);
    int x = 0;
    if (mode == 0) {
      x = (v + rots[i]) % 26;
    }
    else {
      x = (26 + v - rots[i]) % 26;
    }
    char letter = alph[x];
    ans_letters[i] = letter;
  }
  return ans_letters;
}

int main() {
  char msg[] = "hello world";
  char key[] = "test";
  char* enc = vigenere(0, key, sizeof(key)/sizeof(char), msg, sizeof(msg)/sizeof(char));
  char* dec = vigenere(1, key, sizeof(key)/sizeof(char), enc, sizeof(msg)/sizeof(char));
  printf("%s\n", enc);
  printf("%s\n", dec);
  free(enc); free(dec);
}
