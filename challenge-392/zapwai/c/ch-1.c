#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char *flip(char *s) {
  int len = strlen(s);
  char *o = malloc(len+1);
  o[len] = '\0';
  for (int i = 0; i < len; i++)
    o[i] = s[len - i - 1];
  return o;
}

char *palindromize(char *s, int index) {
  char center[2] = {s[index], '\0'};
  char *pre = malloc(50);
  pre[0] = '\0';
  char *post = malloc(50);
  post[0] = '\0';
  strncpy(pre, s, index);
  strcpy(post, s+index+1);
  char *out = calloc(100, 1);

  char *pre3 = calloc(50, 1);
  strcpy(pre3, pre);
  char *post3 = calloc(50, 1);
  strcpy(post3, post);
  
  int diff = strlen(post) - strlen(pre);
  if (diff > 0) {
    char *pre2 = calloc(50, 1);
    char *f = flip(pre);
    strcpy(pre2, f);
    free(f);
    char *addition = calloc(30, 1);
    strcpy(addition, post + strlen(pre));
    strcat(pre2, addition);
    free(addition);
    f = flip(pre2);
    strcpy(pre3, f);
    free(f);
    free(pre2);
  } else {
    char *post2 = calloc(50, 1);
    char *f = flip(post);
    strcpy(post2, f);
    free(f);
    char *addition = calloc(30, 1);
    strcpy(addition, pre + strlen(post));
    strcat(post2, addition);
    free(addition);
    f = flip(post2);
    strcpy(post3, f);
    free(f);
    free(post2);
  }
  
  strcat(out, pre3);
  strcat(out, center);
  strcat(out, post3);
  return out;

  /* # flip pre and make it look like post */
  /*   my $diff = length($post) - length($pre); */
  /*   if ($diff > 0) { */
  /*     $pre = reverse $pre; */
  /*     my $addition = substr $post, length($pre); */
  /*     $pre .= $addition; */
  /*     $pre = reverse $pre; */
  /*   } else { */
  /*     $post = reverse $post; */
  /*     my $addition = substr $pre, length($post); */
  /*     $post .= $addition; */
  /*     $post = reverse $post; */
  /*   } */
  
}

int is_close(char *s) {
  int len = strlen(s);
  char *x = flip(s);
  int close = 0;
  for (int i = 0; i < len - 1; i++)
    if (s[i+1] != x[i]) close = 1;
  /* s is not close to a palindrome */
  if (close == 0) {
    free(x);
    return 1;
  }
  close = 0;
  for (int i = 0; i < len - 1; i++)
    if (s[i] != x[i+1]) close = 1;
  if (close == 0) {
    free(x);
    return -1;
  }
  free(x);
  return 0;
}

void proc(char *s) {
  printf("Input: %s\n", s);
  char *output;
  char *x = flip(s);
  bool pal = false;
  if (strcmp(x,s) == 0) {
    output = s;
    pal = true;
  } else {
    int len = strlen(s);
    int shift = is_close(s);
    if (shift != 0) {
      int axis = len/2 + shift;
      output = palindromize(s, axis);
    } else {
      int cnt = 0;
      for (int i = 0; i < len; i++) {
	if (s[i] == s[i+1]) {
	  cnt++;
	} else {
	  break;
	}
      }
      output = palindromize(s, cnt);
    }
  }
  free(x);
  printf("Output: %s\n", output);
  if (!pal) free(output);
}

int main() {
  char *s = "aacecaaa";
  proc(s);
  s = "abcd";
  proc(s);
  s = "racecar";
  proc(s);
  s = "bananas";
  proc(s);
  s = "aaaaa";
  proc(s);
}

