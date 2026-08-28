#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_STR 50
#define MAX_LIST 100

void proc(int n) {
  printf("Input: %d\n", n);
  char *out[MAX_LIST] = {};
  int olen = 0;
  if (n != 0) {
    for (int i = 1; i < 10000; i++) {
      int ucnt = 0, dcnt = 0;

      char a[2*n+1] = {};
      a[2*n] = '\0';
      int a_len = 0;
      a[a_len++] = 'U';
      ucnt++;
      
      while (a_len < 2*n) {
	if (ucnt > dcnt) {
	  int r = 1 + (rand() % 10);
	  if (r > 5) {
	    a[a_len++] = 'D';
	    dcnt++;
	  } else {
	    a[a_len++] = 'U';
	    ucnt++;
	  }
	} else {
	  a[a_len++] = 'U';
	  ucnt++;
	}
      }

      bool found = false;
      for (int j = 0; j < olen; j++) 
	if (strcmp(a, out[j]) == 0) {
	  found = true;
	  break;
	}
      if ((ucnt == dcnt) && !found) {
	out[olen] = malloc(MAX_STR);
	strcpy(out[olen++], a);
      }
      
    }
  }

  printf("Output: ");
  for (int i = 0; i < olen; i++)
    printf("%s ", out[i]);
  printf("\n");
}
void main() {
  srand(time(NULL));
  int n = 1;
  proc(n);
  n = 2;
  proc(n);
  n = 3;
  proc(n);
  n = 0;
  proc(n);
  n = 4;
  proc(n);
}
