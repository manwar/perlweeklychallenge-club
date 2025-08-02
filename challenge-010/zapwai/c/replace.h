#ifndef REPLACE_H
#define REPLACE_H
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* replace needle with noodle, returns a char* you should free afterward. */
char* replace(char* haystack, char* needle, char* noodle) {
  int wlen = strlen(haystack) + strlen(noodle);
  char* loc = strstr(haystack, needle);
  if (loc == NULL)
    return NULL;
  int start_pt = strlen(haystack) - strlen(loc);
  char* post = malloc(wlen*sizeof(char));
  strcpy(post, &haystack[start_pt + strlen(needle)]);
  char* pre = malloc(wlen*sizeof(char));
  strncpy(pre, haystack, start_pt);
  char* ans = malloc(wlen*sizeof(char));
  strcat(ans, pre);
  strcat(ans, noodle);
  strcat(ans, post);
  free(pre);
  free(post);
  return ans;
}

#endif
