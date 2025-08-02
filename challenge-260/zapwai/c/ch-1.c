#include <stdio.h>
#include <stdbool.h>
#define MAX 100
#define BORK -111111		/* unusable key/value */

struct hash {
  int key[MAX];
  int val[MAX];
  int length;
};

void init(struct hash *h) {
  for (int i = 0; i < MAX; i++) {
    h->key[i] = BORK;
    h->val[i] = BORK;
  }
  h->length = 0;
}

int get(struct hash h, int key) {
  for (int i = 0; i < MAX; i++)
    if (h.key[i] == key) 
      return h.val[i];
  return BORK;
}

void set(struct hash *h, int key, int value) {
  for (int i = 0; i < MAX; i++)
    if (h->key[i] == key)
      h->val[i] = value;
}

void insert(struct hash *h, int key, int value) {
  int index = h->length;
  h->key[index] = key;
  h->val[index] = value;
  h->length++;
}

bool contains(struct hash h, int key) {
  for (int i = 0; i < MAX; i++)
    if (h.key[i] == key)
      return true;
  return false;
}

int has_uniq_freq(struct hash h) {
  for (int i = 1; i < h.length; i++)
    for (int j = 0; j < i; j++)
      if (h.val[j] == h.val[i])
	return 0;
  return 1;
}

void proc(int len, int l[]) {
  printf("Input: { ");
  for (int i = 0; i < len; i++)
    printf("%d ", l[i]);
  printf("}\n");

  struct hash f;
  init(&f);

  for (int i = 0; i < len; i++)
    if (contains(f, l[i]))
      set(&f, l[i], get(f,l[i]) + 1);
    else 
      insert(&f, l[i], 1);

  printf("Output %d\n", has_uniq_freq(f));
}

int main() {
  int l1[] = {1,2,2,1,1,3};
  int l2[] = {1,2,3};
  int l3[] = {-2,0,1,-2,1,1,0,1,-2,9};
  int s1 = sizeof(l1) / sizeof(int);
  int s2 = sizeof(l2) / sizeof(int);
  int s3 = sizeof(l3) / sizeof(int);
  proc(s1, l1);
  proc(s2, l2);
  proc(s3, l3);
}

