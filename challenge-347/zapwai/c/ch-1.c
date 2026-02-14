#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void proc (char *str)  {
  printf("Input: %s\n", str);
  int len = strlen(str);
  char out[11];
  out[10] = '\0';
  out[7] = '-';
  out[4] = '-';
  int gap = 0;
  // day and gap set
  if (len == 13) {		/* two digit day */
    gap++;
    out[8] = str[0];
    out[9] = str[1];
  } else if (len == 12) {	/* one digit day */
    out[8] = '0';
    out[9] = str[0];
  } else {			/* malformed */
    printf("Error in input date\n");
    return;
  }
  // year
  out[0] = str[gap + 8];
  out[1] = str[gap + 9];
  out[2] = str[gap + 10];
  out[3] = str[gap + 11];
  // month
  char month[4];
  month[3] = '\0';
  month[0] = str[gap + 4];
  month[1] = str[gap + 5];
  month[2] = str[gap + 6];
  char *months[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
  int month_num = 0;
  for (int i = 0; i < 12; i++) {
    if (strcmp(month, months[i]) == 0) {
      month_num = i + 1;
      break;
    }
  }
  if (month_num < 10) {
    out[5] = '0';
    out[6] = month_num + '0';
  } else {
    out[5] = '1';
    out[6] = month_num % 10 + '0';
  }
  printf("Output: %s\n", out);
}

int main() {
  char *str = "1st Jan 2025";
  proc(str);
  str = "22nd Feb 2025";
  proc(str);
  str = "31st Dec 2025";
  proc(str);
}
