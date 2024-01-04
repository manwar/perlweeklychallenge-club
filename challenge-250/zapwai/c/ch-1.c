#include <stdio.h>
void proc (int *ints, int len)
{
  int ans = -1;
  for (int i=0; i < len - 1; i++) {
    if (i%10 == ints[i]) {
      ans = i;
      break;
    }
  }
  printf("Input: ints = (");
  for (int i=0; i < len - 2; i++) {
    printf("%d, ",ints[i]);
  }
  printf("%d)\n",ints[len - 1]);
  printf("Output: %d\n",ans);

}

int main () {
  int ints[] = {0,1,2};
  int ints2[] = {4,3,2,1};
  int len = sizeof(ints) / sizeof(int);
  int len2 = sizeof(ints2) / sizeof(int);  
  proc(&ints, len);
  proc(&ints2, len2);  
}