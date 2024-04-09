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
    /* target[current_length] = ; */
    
    int *pre = malloc(current_length * sizeof(int));
    for (int j = 0; j < current_length; j++)
      pre[j] = target[j];

    int *post = malloc((slen - indices[i]) * sizeof(int));
    for (int j = 0; j < slen - indices[i]; j++)
      post[j] = target[j];

    /* Work in progress... */
    
    free(pre);
    free(post);
    current_length++;
    
      /* chunk = splice @target, indices[i]; */
      /* target[indices[i]] = source[i]; */
      /* push @target, @chunk; */
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
