#include <stdio.h>
#include <stdlib.h>


#define MAXROWCNT 10		/* at most 10 people */

void proc(int** party, int m) {	/* m rows passed */
  printf("Input: \n");
  for (int i = 0; i < m; i++) {
    printf("\t");
    for (int j = 0; j < m; j++) {
      printf("%d ", party[i][j]);
    }
    printf("\n");
  }

  int *candidate = malloc(m*sizeof(int));
  int cand_len = 0;
  int sum;
  int celebrity = -1;
  for (int i = 0; i < m; i++) {
    sum = 0;
    for (int j = 0; j < m; j++) {
      if (party[i][j] == 1)
	sum++;
    }
    if (sum == 0)
      candidate[cand_len++] = i;
  }
  for (int j = 0; j < cand_len; j++) {
    sum = 0;
    for (int i = 0; i < m; i++) {
      if (i == candidate[j])
	continue;
      if (party[i][candidate[j]] == 1)
	sum++;
    }
    if (sum == m - 1) {
      celebrity = candidate[j];
    }
  }
  printf("\nOutput: %d\n", celebrity);
}

int main() {
  int **party = malloc(MAXROWCNT*sizeof(int*));
  for (int i = 0; i < MAXROWCNT; i++)
    party[i] = malloc(MAXROWCNT*sizeof(int));
  
  int row0[] = {0, 0, 0, 0, 1, 0};
  int row1[] = {0, 0, 0, 0, 1, 0};
  int row2[] = {0, 0, 0, 0, 1, 0};
  int row3[] = {0, 0, 0, 0, 1, 0};
  int row4[] = {0, 0, 0, 0, 0, 0};
  int row5[] = {0, 0, 0, 0, 1, 0};

  for (int i = 0; i < MAXROWCNT; i++) {
    party[0][i] = row0[i];
    party[1][i] = row1[i];
    party[2][i] = row2[i];
    party[3][i] = row3[i];
    party[4][i] = row4[i];
    party[5][i] = row5[i];
  }

  proc(party, 6);


  int rrow0[] = {0, 1, 1, 0};
  int rrow1[] = {1, 0, 1, 0};
  int rrow2[] = {0, 0, 0, 0};
  int rrow3[] = {0, 0, 0, 0};
  int **pparty = malloc(MAXROWCNT*sizeof(int*));
  for (int i = 0; i < MAXROWCNT; i++)
    pparty[i] = malloc(MAXROWCNT*sizeof(int));
  for (int i = 0; i < MAXROWCNT; i++) {
    pparty[0][i] = rrow0[i];
    pparty[1][i] = rrow1[i];
    pparty[2][i] = rrow2[i];
    pparty[3][i] = rrow3[i];
  }
  
  proc(pparty, 4);
  
  return 0;
}
