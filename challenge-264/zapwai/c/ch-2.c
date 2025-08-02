#include <stdio.h>
#include <stdlib.h>
#define NIL -11111
void proc(int source[], int indices[], int slen) {
  printf("Input: source = { ");
  for (int i = 0; i < slen; i++)
    printf("%d ", source[i]);
  printf("}, indices = { ");
  for (int i = 0; i < slen; i++)
    printf("%d ", indices[i]);
  printf("}\n");

  int target[slen];
  for (int i = 0; i < slen; i++)
    target[i] = NIL;

  int current_length = 0;
  for (int i = 0; i < slen; i++) {
    int *post = malloc((slen - indices[i] - 1) * sizeof(int));
    int *pre = malloc(current_length * sizeof(int));
    for (int j = 0; j < current_length; j++)
      pre[j] = target[j];
    for (int j = 0; j < slen - indices[i] - 1; j++)
      post[j] = target[indices[i] + j];

    int skip = 0;		/* 0, or 1 if replacement occurs */
    int current_value = NIL;		/* gets replaced */
    if (current_length > indices[i]) {
      current_value = target[indices[i]];
      skip = 1;
    }
    
    target[indices[i]] = source[i];
    if (current_value != NIL)
      target[indices[i] + 1] = current_value;
    
    if (current_length > indices[i]) {
      for (int j = 0; j < slen - indices[i] - 1; j++)
	target[indices[i] + j + skip] = post[j];
    }

    free(pre);
    free(post);
    current_length++;
  }
  printf("Output: { ");
  for (int i = 0; i < slen; i++)
    printf("%d ", target[i]);
  printf("}\n");
}

int main() {
  int source[]  = {0, 1, 2, 3, 4};
  int indices[] = {0, 1, 2, 2, 1};
  proc(source, indices, sizeof(source) / sizeof(int));

  int source2[]  = {1, 2, 3, 4, 0};
  int indices2[] = {0, 1, 2, 3, 0};
  proc(source2, indices2, sizeof(source2) / sizeof(int));

  int source3[] = {1};
  int indices3[] = {0};
  proc(source3, indices3, sizeof(source3) / sizeof(int));
}