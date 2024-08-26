#include <stdio.h>
#include "vec.h"

void proc(int l1[], int l2[], int l1len, int l2len) {
  printf("Input: \n");
  printf(" List1 = { ");
  for (int i = 0; i < l1len; i++)
    printf("%d ", l1[i]);
  printf("}\n");
  printf(" List2 = { ");
  for (int i = 0; i < l2len; i++)
    printf("%d ", l2[i]);
  printf("}\n");
  vec* tail = new_vec('i');
  for (int i = 0; i < l1len; i++) {
    int item = l1[i];
    int elem_of_l2_flag = 0;
    for (int j = 0; j < l2len; j++) {
      int item2 = l2[j];
      if (item == item2) {
	elem_of_l2_flag = 1;
	break;
      }
    }
    if (elem_of_l2_flag == 0)
      push(tail, &item);
  }
  vec* out = new_vec('i');
  for (int j = 0; j < l2len; j++) {
    int item2 = l2[j];
    for (int i = 0; i < l1len; i++) {
      int item = l1[i];
      if (item == item2)
	push(out, &item);
    }
  }
  sort(tail);
  for (int i = 0; i < tail->size; i++)
    push(out, &tail->data[i]);
  printf("Output: ");
  display(out);
  printf("\n");
  destroy_vec(tail);
  destroy_vec(out);
}

int main() {
  int list1[] = {2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5};
  int list2[] = {2, 1, 4, 3, 5, 6};
  proc(list1, list2, sizeof(list1)/sizeof(int), sizeof(list2)/sizeof(int));
  int alist1[] = {3, 3, 4, 6, 2, 4, 2, 1, 3};
  int alist2[] = {1, 3, 2};
  proc(alist1, alist2, sizeof(alist1)/sizeof(int), sizeof(alist2)/sizeof(int));
  int blist1[] = {3, 0, 5, 0, 2, 1, 4, 1, 1};
  int blist2[] = {1, 0, 3, 2};
  proc(blist1, blist2, sizeof(blist1)/sizeof(int), sizeof(blist2)/sizeof(int));
}
