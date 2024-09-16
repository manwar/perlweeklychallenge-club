#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdbool.h>

bool is_number(char* str) {
  for (int i = 0; i < strlen(str); i++)
    if (!isdigit(str[i]))
      return false;
  return true;
}

bool is_dEd(char* str) {
  //   ^\d+e|E\d+
  char chunk[10][50];
  int j = 0;
  char *q;
  char *p = strchr(str, 'e');
  if (p != NULL) {
    q = strtok(str, "e");
    while (q != NULL) {
      strcpy(chunk[j++], q);
      q = strtok(NULL, "e");
    }
    if (j != 2)
	return false;
    if (is_number(chunk[0]) && is_number(chunk[1]))
      return true;
  } else {
    p = strchr(str, 'E');
    if (p != NULL) {
      q = strtok(str, "E");
      while (q != NULL) {
	strcpy(chunk[j++], q);
	q = strtok(NULL, "E");
      }
      if (j != 2)
	return false;
      if (is_number(chunk[0]) && is_number(chunk[1]))
	return true;
    } else {
      return false;
    }
  }
  return false;
}


void proc(char str[]) {
  printf("Input: %s\n", str);
  char* output = "False";
  char piece[100][100];
  int plen = 0;
  char* p = strtok(str, ".");
  while (p != NULL) {
    strcpy(piece[plen++], p);
    p = strtok(NULL, ".");
  }
  
  if (plen == 1) {
    if (is_number(str)) {
      output = "True";
    } else if (is_dEd(str)) {
      output = "True";
    }
  } else if (plen == 2) {
    if (is_number(piece[0]) && is_number(piece[1])) {
      output = "True";
    } else if (is_number(piece[0]) && is_dEd(piece[1])) {
      output = "True";
    }
  }
  printf("Output: %s\n", output);
}

int main() {
  char str[] = "1";
  proc(str);
  char str2[] = "56e10";
  proc(str2);
  char str3[] = "2E32";
  proc(str3);
  char str4[] = "a";
  proc(str4);
  char str5[] = "1.2";
  proc(str5);
  char str6[] = "1.2.6";
  proc(str6);
  char str7[] = "3.142e10";
  proc(str7);
  char str8[] = "3.142e42B";
  proc(str8);
}

