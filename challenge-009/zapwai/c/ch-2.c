#include <stdio.h>
#include "vec.h"

void display_array(int* a, int alen) {
  printf("{");
  for (int i = 0; i < alen - 1; i++)
    printf("%d, ", a[i]);
  printf("%d}\n", a[alen - 1]);
}

void standard(int* a, int alen) {
  vec v;
  init_vec(&v);
  int rank = 1;
  int lvl = a[0];
  for (int i = 0; i < alen; i++) {
    if (a[i] > lvl) {
      rank = i + 1;
      lvl = a[i];
    }
    push(&v, rank);
  }
  printf("Stand: ");
  display(&v);
  destroy_vec(&v);
}

void modified(int* b, int blen) {
  vec v;
  init_vec(&v);
  
  vec a;
  init_vec(&a);
  for (int i = 0; i < blen; i++)
    push(&a, b[i]);
  reverse(&a);

  int lvl = a.data[0];
  int rank = blen;
  for (int i = 0; i < blen; i++) {
    if (a.data[i] < lvl) {
      rank = blen - i;
      lvl = a.data[i];
    }
    push(&v, rank);
  }
  reverse(&v);
  printf("Modif: ");
  display(&v);
  destroy_vec(&v);
}

void dense(int* a, int alen) {
  vec v;
  init_vec(&v);
  int rank = 1;
  int lvl = a[0];

  for (int i = 0; i < alen; i++) {
    if (a[i] > lvl) {
      rank++;
      lvl = a[i];
    }
    push(&v, rank);
  }
  printf("Dense: ");
  display(&v);
  destroy_vec(&v);
}

void proc(int* a, int alen) {
  printf("Input: ");
  display_array(a, alen);
  standard(a, alen);
  modified(a, alen);
  dense(a, alen);
  printf("\n");
}
  

int main() {
  int a1[] = {1, 2, 2, 3};
  int alen1 = sizeof(a1) / sizeof(int);

  int a2[] = {1, 4, 6, 6, 8, 10, 10};
  int alen2 = sizeof(a2) / sizeof(int);
  
  int a3[] = {1, 2, 2, 4, 4, 4, 5, 7, 9, 11, 11, 11};
  int alen3 = sizeof(a3) / sizeof(int);

  int a4[] = {3, 3, 6, 6};
  int alen4 = sizeof(a4) / sizeof(int);

  proc(a1, alen1);
  proc(a2, alen2);
  proc(a3, alen3);
  proc(a4, alen4);
}
