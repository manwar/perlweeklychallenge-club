#include <stdio.h>
#include <string.h>

void proc(char *s) {
  printf("Input: %s\n", s);
  char first[3];
  strncpy(first, s, 3);
  char second[2];
  strncpy(second, s+3, 2);
  char third = s[5];
  int outcome[3];
  outcome[0] = (first[0] == 'H') ? 2 : 7;
  outcome[1] = (first[1] == 'H') ? 3 : 6;
  outcome[2] = (first[2] == 'H') ? 4 : 5;

  int one[] = {1, outcome[1]};
  int two[] = {outcome[0], outcome[2]};
  // sort two
  if (outcome[0] > outcome[2]) {
    two[0] = outcome[2];
    two[1] = outcome[0];
  }
  
  int outcome2[2];
  outcome2[0] = (second[0] == 'H') ? one[0] : one[1];
  outcome2[1] = (second[1] == 'H') ? two[0] : two[1];

  // sort outcome2
  if (outcome2[0] > outcome2[1]) {
    int tmp = outcome2[0];
    outcome2[0] = outcome2[1];
    outcome2[1] = tmp;
  }
  printf("Output: \n");
  printf("Team %d hosts team %d.\n", outcome2[0], outcome2[1]);
  printf("Team %d is the winner.\n", (third == 'H') ? outcome2[0] : outcome2[1]);
}

int main() {
  char *s = "HAHAHH";
  proc(s);
  s = "HHHHHH";
  proc(s);
  s = "HHHAHA";
  proc(s);
  s = "HAHAAH";
  proc(s);
  s = "HAAHAA";
  proc(s);
}
