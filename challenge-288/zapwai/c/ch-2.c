#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include "vec.h"

#define ENTRYLEN 6		/* dd-dd\0 */
#define BLOCKLEN 60001
/* These constants work for matrix up to size 99^2 */
/* "dd-dd " x 10,000 entries*/

struct hash {
  char key[BLOCKLEN][ENTRYLEN];
  int val[BLOCKLEN];
  int size;
};

bool contains(struct hash h, char *entry) {
  for (int i = 0; i < h.size; i++)
    if (0 == strcmp(h.key[i], entry))
      return true;
  return false;
}

bool intersection(char *a, char *b) {
  char *A = malloc(BLOCKLEN);
  strcpy(A, a);
  char *B = malloc(BLOCKLEN);
  char *entry1;
  char *saveptr1, *saveptr2;
  entry1 = strtok_r(A, " ", &saveptr1);
  while (entry1 != NULL) {
    strcpy(B, b);
    char *entry2;
    entry2 = strtok_r(B, " ", &saveptr2);
    while (entry2 != NULL) {
      if (0 == strcmp(entry1, entry2)) {
	free(A); free(B);
	return true;
      }
      entry2 = strtok_r(NULL, " ", &saveptr2);
    }
    entry1 = strtok_r(NULL, " ", &saveptr1); 
  }
  free(A); free(B);
  return false;
}

void merge(vec *c) {
  for (int i1 = 0; i1 < c->size - 1; i1++) {
    for (int i2 = i1 + 1; i2 < c->size; i2++) {
      if (intersection(c->datas[i1], c->datas[i2])) {
	struct hash h = { .size = 0 };
	char *C1 = malloc(BLOCKLEN);
	strcpy(C1, c->datas[i1]);
	char *entry1;
	entry1 = strtok(C1, " ");
	while (entry1 != NULL) {
	  if (!contains(h, entry1)) {
	    strcpy(h.key[h.size], entry1);
	    h.val[h.size++] = 1;
	  }
	  entry1 = strtok(NULL, " ");
	}
	char *C2 = malloc(BLOCKLEN);
	strcpy(C2, c->datas[i2]);
	char *entry2;
	entry2 = strtok(C2, " ");
	while (entry2 != NULL) {
	  if (!contains(h, entry2)) {
	    strcpy(h.key[h.size], entry2);
	    h.val[h.size++] = 1;
	  }
	  entry2 = strtok(NULL, " ");
	}
	free(C1);
	free(C2);
	strcpy(c->datas[i1], "");
	char *sr = malloc(BLOCKLEN);
	strcpy(sr, "");
	for (int i = 0; i < h.size; i++) {
	  char *sq = malloc(ENTRYLEN);
	  sprintf(sq, "%s ", h.key[i]);
	  strcat(sr, sq);
	  free(sq);
	}
	strcpy(c->datas[i2], sr);
	free(sr);
      }
    }
  }
}

void contigu(int m, int n, char matrix[m][n], char *entry, vec *c) {
  vec *blocks = new_vec('s');
  push(blocks, entry);
  for (int i = 0; i < blocks->size; i++) {
    char *block = malloc(ENTRYLEN);
    strcpy(block, blocks->datas[i]);
    char *tok;
    tok = strtok(block, "-");
    int y = atoi(tok);
    tok = strtok(NULL, "-");
    int x = atoi(tok);
    free(block);
    if (x + 1 < n) {
      if (matrix[y][x] == matrix[y][x+1]) {
	char *ms = malloc(ENTRYLEN);
	sprintf(ms, "%d-%d", y, x+1);
	push(blocks, ms);
	free(ms);
      }
    }
    if (y + 1 < m) {
      if (matrix[y][x] == matrix[y+1][x]) {
	char *ms = malloc(ENTRYLEN);
	sprintf(ms, "%d-%d", y+1, x);
	push(blocks, ms);
	free(ms);
      }
    }
    
  }
  char *sr = malloc(BLOCKLEN);
  strcpy(sr, "");
  for (int i = 0; i < blocks->size; i++) {
    char *sq = malloc(ENTRYLEN);
    sprintf(sq, "%s ", blocks->datas[i]);
    strcat(sr, sq);
    free(sq);
  }
  push(c, sr);
  free(sr);
  destroy_vec(blocks);
}

void proc(int m, int n, char matrix[m][n]) {
  printf( "Input: matrix = \n");
  for (int i = 0; i < m; i++) {
    printf("\t");
    for (int j = 0; j < n; j++)
      printf("%c", matrix[i][j]);
    printf("\n");
  }
  printf("\n");
  vec *contig = new_vec('s');
  contigu(m, n, matrix, "0-0", contig);
  for (int i = 0; i < m; i++) {
    for (int j = 0; j < n; j++) {
      bool got_flag = false;
      char *entry = malloc(ENTRYLEN);
      sprintf(entry, "%d-%d", i, j);
      for (int k = 0; k < contig->size; k++){
	char *b = malloc(BLOCKLEN);
	strcpy(b, contig->datas[k]);
	char s[BLOCKLEN][ENTRYLEN] = {};
	int slen = 0;
	char *p = strtok(b, " ");
	while(p != NULL) {
	  strcpy(s[slen++], p);
	  p = strtok(NULL, " ");
	}
	for (int i = 0; i < slen; i++)
	  if (0 == strcmp(s[i], entry))
	    got_flag = true;
      }
      if (!got_flag)
	contigu(m, n, matrix, entry, contig);
      free(entry);
    }
  }
  merge(contig);
  int cnt = 0;
  for (int i = 0; i < contig->size; i++) {
    char *c = contig->datas[i];
    if (0 != strcmp("", c))
      printf("%s\n", c);
    int len = 0;
    for (int j = 0; j < strlen(c); j++)
      if (c[j] == '-')
	len++;
    if (cnt < len)
      cnt = len;
  }
  printf( "\nOutput: %d\n\n", cnt);
  destroy_vec(contig);
}

int main() {
  char matrix[4][5] = {{'x', 'x', 'x', 'x', 'o'},
		       {'x', 'o', 'o', 'o', 'o'},
		       {'x', 'o', 'o', 'o', 'o'},
		       {'x', 'x', 'x', 'o', 'o'},
  };
  proc(4, 5, matrix);
  char matrix2[4][5] = {{'x', 'x', 'x', 'x', 'x'},
			{'x', 'o', 'o', 'o', 'o'},
			{'x', 'x', 'x', 'x', 'o'},
			{'x', 'o', 'o', 'o', 'o'},
  };
  proc(4, 5, matrix2);
  char matrix3[4][5] = {{'x', 'x', 'x', 'o', 'o'},
			{'o', 'o', 'o', 'x', 'x'},
			{'o', 'x', 'x', 'o', 'o'},
			{'o', 'o', 'o', 'x', 'x'},
  };
  proc(4,5,matrix3);
}

