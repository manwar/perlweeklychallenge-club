#include <stdio.h>

void proc(char *src, char *tar) {
  printf("Input:  Source = \"%s\"\n", src);
  printf("\tTarget = \"%s\"\n", tar);
  int src_hr, tar_hr, src_min, tar_min;
  sscanf(src, "%2d:%2d", &src_hr, &src_min);
  sscanf(tar, "%2d:%2d", &tar_hr, &tar_min);
  int src_in_min = 60*src_hr + src_min, tar_in_min = 60*tar_hr + tar_min;
  int diff = tar_in_min - src_in_min;
  if (diff < -12*60)
    diff += 24*60;
  printf(" (Difference is %d minutes ->", diff);
  int factor[4] = {};
  int time[] = {1,5,15,60};
  int sum = 0;
  for (int i = 3; i >= 0; i--) {
    factor[i] = diff / time[i];
    diff -= factor[i]*time[i];
    sum += factor[i];
    printf(" %d (%d)", factor[i], time[i]);
  }
  printf(")\nOutput: %d\n\n", sum);
}

int main() {
  char *src = "02:30";
  char *tar = "02:45";
  proc(src, tar);
  
  src = "11:55";
  tar = "12:15";
  proc(src, tar);
  
  src = "09:00";
  tar = "13:00";
  proc(src, tar);
  
  src = "23:45";
  tar = "00:30";
  proc(src, tar);

  src = "14:20";
  tar = "15:25";
  proc(src, tar);
}
