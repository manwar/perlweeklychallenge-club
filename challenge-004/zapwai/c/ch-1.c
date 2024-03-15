#include <stdio.h>
#include <stdlib.h>
int main(int argc, char* argv[]) {
  FILE* fp = fopen("004-1.c", "r");
  fseek(fp, 0L, SEEK_END);
  int sz = ftell(fp);
  fclose(fp);
  char url[] = "http://www.geom.uiuc.edu/~huberty/math5337/groupe/digits.html";
  char args[100];
  sprintf(args, "curl -s %s > pi.txt", url);
  system(args);
  FILE* fp2 = fopen("pi.txt", "r");
  fseek(fp2, 326, SEEK_SET);
  char data[sz+7];
  int numread = fread(data, sizeof(char), sz+7, fp2);
  fclose(fp2);
  for (int i = 0; i < sz+7; i++) {
    if (data[i] != '\n') {
      printf("%c", data[i]);
    }
  }
  printf("\n");
}
