#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define hex_string "0123456789ABCDEF"

int to_dec(char a, char b) {
  int val1 = 16*(strchr(hex_string, a) - hex_string);
  int val2 = strchr(hex_string, b) - hex_string;
  return val1 + val2;
}

void proc(char *color) {
  printf("Input: %s\n", color);
  char o[8];
  o[0] = '#';
  o[7] = '\0';
  for (int j = 0; j <= 4; j += 2) {
    char a = color[1 + j];
    char b = color[2 + j];
    int val = to_dec(a, b);
    int safe_dec[] = {0, 51, 102, 153, 204, 255};
    char *safe_val = "00336699CCFF";
    int min_ind = 0;
    int min = 256;
    for (int i = 0; i < 6; i++) {
      int diff = abs(val - safe_dec[i]);
      if (min > diff) {
	min_ind = i;
	min = diff;
      }
    }
    o[1 + j] = safe_val[2*min_ind];
    o[2 + j] = safe_val[2*min_ind + 1]; 
  }
  
  printf("Output: %s\n", o);
}

int main() {
  char *color = "#F4B2D1";
  proc(color);
  color = "#15E6E5";
  proc(color);
  color = "#191A65";
  proc(color);
  color = "#2D5A1B";
  proc(color);
  color = "#00FF66";
  proc(color);
}
