#include <stdio.h>
#include <string.h>
#include <stdlib.h>
void proc(char *n1, char *n2) {
  printf("Input: %s, %s\n", n1, n2);
  char out[30];
  out[0] = '\0';
  char *p1 = strchr(n1, '+');
  char *p2 = strchr(n2, '+');
  char *i1 = strchr(n1, 'i');
  char *i2 = strchr(n2, 'i');
  char *as = malloc(10);
  char *bs = malloc(10);
  char *cs = malloc(10);
  char *ds = malloc(10);
  strncpy(as, n1, p1-n1);
  strncpy(bs, p1+1, i1 - p1 - 1);
  strncpy(cs, n2, p2-n2);
  strncpy(ds, p2+1, i2 - p2 - 1);
  // strip parentheses
  if (ds[0] == '(') {
    int len = strlen(ds);
    ds[len-1] = '\0';
    for (int i = 0; i < len; i++)
      ds[i] = ds[i+1];
  }
  if (cs[0] == '(') {
    int len = strlen(cs);
    cs[len-1] = '\0';
    for (int i = 0; i < len; i++)
      cs[i] = cs[i+1];
  }
  if (bs[0] == '(') {
    int len = strlen(bs);
    bs[len-1] = '\0';
    for (int i = 0; i < len; i++)
      bs[i] = bs[i+1];
  }
  if (as[0] == '(') {
    int len = strlen(as);
    as[len-1] = '\0';
    for (int i = 0; i < len; i++)
      as[i] = as[i+1];
  }  
  int a = atoi(as);
  int b = atoi(bs);
  int c = atoi(cs);
  int d = atoi(ds);
  int re = a*c-b*d;
  int im = a*d+b*c;
  sprintf(out, "%d+%di", re, im);
  printf("Output: %s\n", out);
  free(as);
  free(bs);
  free(cs);
  free(ds);
}

int main() {
  char *n1 = "1+1i";
  char *n2 = "1+1i";
  proc(n1, n2);
  n1 = "1+(-1)i"; n2 = "1+(-1)i";
  proc(n1, n2);
  n1 = "0+3i"; n2 = "0+4i";
  proc(n1, n2);
  n1 = "3+4i"; n2 = "3+(-4)i";
  proc(n1, n2);
  n1 = "50+(-20)i"; n2 = "-10+30i";
  proc(n1, n2);
}
