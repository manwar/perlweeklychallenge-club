#include <stdio.h>
#include "vec.h"

vec* moves(char coord[]) {
  char l = coord[0];
  int row = atoi(&coord[1]);
  char *cols = "abcdefgh";
  char *k;
  k = strchr(cols, l);
  int col = 1 + (int)(k - cols);
  vec *r = new_vec('i');
  vec *c = new_vec('i');
  for (int i = -2; i <= 2; i++) {
    if (i == -2 || i == 2) {
      for (int j = -1; j <= 1; j++) {
	if (j == -1 || j == 1) {
	  int cval = col + i;
	  push(c, &cval);
	  int rval = row + j;
	  push(r, &rval);
	}
      }
    }
  }
  for (int i = -1; i <= 1; i++) {
    if (i == -1 || i == 1) {
      for (int j = -2; j <= 2; j++) {
	if (j == -2 || j == 2) {
	  int cval = col + i;
	  push(c, &cval);
	  int rval = row + j;
	  push(r, &rval);
	}
      }
    }
  }
  vec *list = new_vec('s');
  for (int i = 0; i <= 7; i++) {
    if (c->data[i] < 1 || c->data[i] > 8)
      continue;
    if (r->data[i] < 1 || r->data[i] > 8)
      continue;
    char move[3];
    move[0] = cols[c->data[i] - 1];
    move[1] = r->data[i] + '0';
    move[2] = '\0';
    push(list, move);
  }
  destroy_vec(c);
  destroy_vec(r);
  return list;
}

void proc(char start[], char end[]) {
  printf("Input: %s to %s\n", start, end);
  vec* list[10];
  list[0] = moves(start);
  int round = -1;
  int found = 0;
  while (found == 0) {
    round++;
    for (int i = 0; i < list[round]->size; i++) {
      char* old_move = list[round]->datas[i];
      if (0 == strcmp(old_move, end))
	found = 1;
    }
    if (found == 1) {
      break;
    } else {
      list[round+1] = new_vec('s');
      vec* L[list[round]->size];
      for (int i = 0; i < list[round]->size; i++) {
	char* old_move = list[round]->datas[i];
	L[i] = moves(old_move);
	for (int j = 0; j < L[i]->size; j++) {
	  char* ch = L[i]->datas[j];
	  push(list[round+1], ch);
	}
      }
    }
  }
  printf( "Output: %d\n", round+1);
  for (int i = 0; i < round; i++)
    destroy_vec(list[i]);
}


int main() {
  char start[] = "g2";
  char end[] = "a8";
  proc(start, end);

  char start2[] = "g2";
  char end2[] = "h2";
  proc(start2, end2);
}
