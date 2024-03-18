#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>

float jw(char*, char*);
float jsim(char*, char*);
int* num_matches(char*, char*, int);

int main() {
  char* s1 = "faremviel";
  char* s2 = "farmville";
  printf("%f\n", jw(s1, s2));
}

float jw(char* s1, char* s2) {
  float j_sim = jsim(s1, s2);
  float p = 0.1;
  int l = 0;
  for (int i = 0; i < 4; i++)
    if (s1[i] == s2[i])
      l++;
  float w_sim = j_sim + l*p*(1 - j_sim);
  return 1 - w_sim;
}

float jsim(char* s1, char* s2) {
  int l1 = strlen(s1);
  int l2 = strlen(s2);
  int offset = fmax(l1, l2) / 2;
  int* mt = num_matches(s1, s2, offset);
  int m = mt[0];
  int t = mt[1];
  free(mt);
  return (m > 0) ? (1/3.0 * ((float) m/l1 + (float) m/l2 + (float) (m - t)/m)) : 0;
}

int* num_matches(char* s1, char* s2, int offset) {
  int cnt = 0;
  int trans = 0;
  for (int i = 0; i < strlen(s1); i++) {
    bool found_match = false;
    for (int j = 0; j < strlen(s2); j++)
      if (!found_match)
	if (abs(i - j) < offset) 
	  if (s1[i] == s2[j]) {
	    found_match = true;
	    cnt++;
	    if (i != j)
	      if (((i + 1 < strlen(s1)) && (s1[i] == s2[i + 1]) && (s2[i] == s1[i + 1])) || ((i - 1 >= 0) && (s1[i] == s2[i - 1]) && (s2[i] == s1[i - 1])))
		trans++;
	  }
  }
  int* mt = malloc( 2 * sizeof(int) );
  mt[0] = cnt;
  mt[1] = (int) trans/2;
  return mt;
}
