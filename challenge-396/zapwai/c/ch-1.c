#include <stdio.h>

void proc(int m, int order[m], int n, int friends[n]) {
  printf("Input:  order = ");
  for (int i = 0; i < m; i++)
    printf("%d ", order[i]);
  printf("\n\tfriends = ");
  for (int i = 0; i < n; i++)
    printf("%d ", friends[i]);
  printf("\nOutput: ");
  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++)
      if (friends[j] == order[i])
	printf("%d ", order[i]);
  }
  printf("\n");
}

int main() {
  int order[] = {3,1,4,2,5};
  int friends[] = {1,2,4};
  proc(sizeof(order)/sizeof(int), order, sizeof(friends)/sizeof(int), friends);
  int order2[] = {5, 4, 3, 2, 1};
  int friends2[] = {1, 3, 5};
  proc(sizeof(order2)/sizeof(int), order2, sizeof(friends2)/sizeof(int), friends2);
  int order3[] = {2, 4, 1, 3};
  int friends3[] = {1, 2, 3, 4};
  proc(sizeof(order3)/sizeof(int), order3, sizeof(friends3)/sizeof(int), friends3);
  int order4[] = {4, 1, 3, 2};
  int friends4[] = {3};
  proc(sizeof(order4)/sizeof(int), order4, sizeof(friends4)/sizeof(int), friends4);
  int order5[] = {1, 3, 2, 6, 5, 4};
  int friends5[] = {1, 2, 3};
  proc(sizeof(order5)/sizeof(int), order5, sizeof(friends5)/sizeof(int), friends5);
}
