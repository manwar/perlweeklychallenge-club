#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void proc(char* ip) {
  char* out = malloc(100 * sizeof(char));
  int j = 0;
  for (int i = 0; i < strlen(ip); i++) {
    if (ip[i] == '.') {
      out[j++] = '[';
      out[j++] = '.';
      out[j] = ']';
    } else {
      out[j] = ip[i];
    }
    j++;
  }
  out[j] = '\0';
  printf( "Input: %s\n", ip);
  printf( "Output: %s\n", out);
  free(out);
}

int main() {
  char* ip = "1.1.1.1";
  proc(ip);
  char* ip2 = "255.101.1.0";
  proc(ip2);
}
