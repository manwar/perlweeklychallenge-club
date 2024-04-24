#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>
#define SETSIZE 100
#define WORDSIZE 30

typedef struct {
  char key;
  int value;
} item;

item* get(item* items, int size, char key) {
  for (size_t i = 0; i < size; i++)
    if (items[i].key == key)
      return &items[i];
  return NULL;
}

void insert(item* items, size_t size, char key, int val) {
  int cnt = 0;
  for (int i = 0; i < size; i++) {
    if (items[i].key == key) {
      items[i].value = val;
      break;
    }
    cnt++;
  }
  if (cnt == size) {
    items[size].key = key;
    items[size].value = val;
  }
}

item* freq(char* stringy, int *size) {
  item* f = malloc(SETSIZE * sizeof(item));
  int f_size = 0;
  for (int i = 0; i < strlen(stringy); i++) {
    char letter = stringy[i];
    if (isalpha(letter)) {
      char let = tolower(letter);
      item* cell = get(f, f_size, let);
      if (!cell) {
	insert(f, f_size, let, 1);
	f_size++;
      } else {
	insert(f, f_size, let, cell->value + 1);
      }
    }
  }
  *size = f_size;
  return f;
}

// Return true if g contains f
bool hash_contains(item* g, item* f, int g_size, int f_size) {
  int cnt = 0;
  for (int i = 0; i < f_size; i++) {
    char key = f[i].key;
    item* gcell = get(g, g_size, key);
    if (!gcell) {
      free(f);
      free(g);
      return false;
    } else {
      item* fcell = get(f, f_size, key);
      if (fcell->value <= gcell->value)
	cnt++;
    }
  }
  free(f);
  free(g);
  return (cnt == f_size);
}

void proc(char* stringy, char* strlist[], int slen) {
  printf("Input:  str = %s\n \tlist: ", stringy);
  char* ans[slen];
  int len = 0;
  for (int i = 0; i < slen; i++) {
    ans[i] = NULL;
    int f_size = 0;
    int g_size = 0;
    if (hash_contains(freq(strlist[i], &g_size), freq(stringy, &f_size), g_size, f_size)) {
      ans[len] = malloc(WORDSIZE * sizeof(char));
      strcpy(ans[len], strlist[i]);
      len++;
    }
    printf("%s ", strlist[i]);
  }
  printf("\n");
  int min = strlen(ans[0]);
  char* answer = malloc(sizeof(char) * WORDSIZE);
  strcpy(answer, ans[0]);
  for (int i = 0; i < len; i++) {
    if (strlen(ans[i]) < min) {
      min = strlen(ans[i]);
      strcpy(answer, ans[i]);
    }
    free(ans[i]);
  }
  if (len > 0)
    printf("Output: %s\n", answer);
  free(answer);
}

int main() {
  char* stringy = "aBc 11c";
  char* strlist[] = {"accbbb", "abc", "abbc"};
  proc(stringy, strlist, 3);

  stringy = "La1 abc";
  char* strlist2[] = {"abcl", "baacl", "abaalc"};
  proc(stringy, strlist2, 3);

  stringy = "JB 007";
  char* strlist3[] = {"jj", "bb", "bjb"};
  proc(stringy, strlist3, 3);
}
