#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int parse_time(const char *s) {
  return ((s[0]-'0')*10 + (s[1]-'0')) * 60 + ((s[3]-'0')*10 + (s[4]-'0'));
}

char *conflict(char *event1[2], char *event2[2]) {
  int t11 = parse_time(event1[0]);
  int t12 = parse_time(event1[1]);
  int t21 = parse_time(event2[0]);
  int t22 = parse_time(event2[1]);

  /* Midnight issues */
  if (t12 < t11) t12 += 24*60;
  if (t22 < t21) t22 += 24*60;

  if (t12 > t21 && t11 < t22) { return "true"; }
  
  t21 += 24*60;
  t22 += 24*60;

  if (t11 < t22 && t21 < t12) return "true";
 
  return "false";
}

void proc(char *event1[2], char *event2[2]) {
  printf("Input: Event 1: %s - %s\tEvent 2: %s - %s\n", event1[0], event1[1], event2[0], event2[1]);
  printf("Output: %s\n", conflict(event1, event2));
}

int main() {
  char *event1[2] = {"10:00", "12:00"};
  char *event2[2] = {"11:00", "13:00"};
  proc(event1, event2);
  char *event11[2] = {"09:00", "10:30"};
  char *event21[2] = {"10:30", "12:00"};
  proc(event11, event21);
  char *event12[2] = {"14:00", "15:30"};
  char *event22[2] = {"14:30", "16:00"};
  proc(event12, event22);
  char *event13[2] = {"08:00", "09:00"};
  char *event23[2] = {"09:01", "10:00"};
  proc(event13, event23);
  char *event14[2] = {"23:30", "00:30"};
  char *event24[2] = {"00:00", "01:00"};
  proc(event14, event24);
}
