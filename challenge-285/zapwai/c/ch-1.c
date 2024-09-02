#include <stdio.h>
#include <string.h>

void proc(char routes[][2][3], int len) {
  printf("Input: ");
  for (int i = 0; i < len; i++) {
    printf("%s->%s ", routes[i][0], routes[i][1]);
  }
  printf("\n");
  char in[len][3];
  char out[len][3];
  int in_cnt = 0;
  int out_cnt = 0;
  for (int i = 0; i < len; i++) {
    strcpy(in[in_cnt++], routes[i][0]);
    strcpy(out[out_cnt++], routes[i][1]);
  }
  char ans[3] = "";
  
  for (int i = 0; i < out_cnt; i++) {
    int found = 0;
    for (int j = 0; j < in_cnt; j++) {
      if (0 == strcmp(out[i], in[j])) {
	found = 1;
	break;
      }
    }
    if (found == 0) {
      strcpy(ans, out[i]);
    }
  }
  printf("Output: %s\n", ans);
}

int main() {
  char routes[3][2][3] = {{"B","C"}, {"D","B"}, {"C","A"}};
  proc(routes, 3);
  char routes2[1][2][3] = {{"A","Z"}};
  proc(routes2, 1);
}
