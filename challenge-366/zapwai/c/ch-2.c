#include <stdio.h>

int hour_opt(char hr[2]) {
  if (hr[0] == '?' && hr[1] == '?') {
	return 24;
    } else if (hr[0] == '?') {
	if (hr[1]-'0' > 3) {
	    return 2;
	} else {
	    return 3;
	}
    } else {
	if (hr[0]-'0' == 2) {
	    return 4;
	} else {
	    return 10;
	}
    }
}

int min_opt(char min[2]) {
  if (min[0] == '?' && min[1] == '?') {
	return 60;
    } else if (min[0] == '?') {
	return 6;
    } else {
	return 10;
    }
}

void proc(char *s) {
  printf("Input: %s\n", s);
  char hr[2];
  hr[0] = s[0];
  hr[1] = s[1];
  char min[2];
  min[0] = s[3];
  min[1] = s[4];
  int hr_tot = 1, min_tot = 1;
  if (hr[0] == '?' || hr[1] == '?') {
    hr_tot = hour_opt(hr);
  }
  if (min[0] == '?' || min[1] == '?') {
    min_tot = min_opt(min);
  }
  printf("Output: %d\n", hr_tot * min_tot);
}

int main() {
  char *time = "?2:34";
  proc(time);

  time = "?4:?0";
  proc(time);

  time = "??:??";
  proc(time);

  time = "?3:45";
  proc(time);

  time = "2?:15";
  proc(time);

}
