#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "replace.h"

int roman(char c) {
  char r[] = {'I', 'V', 'X', 'L', 'C', 'D', 'M'};
  int v[] = {1, 5, 10, 50, 100, 500, 1000};
  for (int i = 0; i < sizeof(r) / sizeof(char); i++) 
    if (r[i] == c)
      return v[i];
  return -1;
}

void convert_from_roman(char* s) {
  char* basic[] = { "IIII", "VIIII", "XXXX", "LXXXX", "CCCC", "DCCCC" };
  char* modern[] = { "IV", "IX", "XL", "XC", "CD", "CM" };
  printf("Input: %s\n",s);
  char** arr = malloc(8 *sizeof(char*));
  int arr_cnt = 0;
  for (int i = 0; i < sizeof(basic) / sizeof(char*); i++) {
    char* key = modern[i];
    char* val = basic[i];
    if (strstr(s, key) != NULL) {
      if (arr_cnt == 0)
	arr[0] = replace(s, key, val);
      else 
	arr[arr_cnt] = replace(arr[arr_cnt-1], key, val);
      arr_cnt++;
    }
  }
  int sum = 0;
  for (int i = 0; i < strlen(arr[arr_cnt-1]); i++)
    sum += roman(arr[arr_cnt - 1][i]);
  printf("Output: %d\n", sum);
  for (int i = 0; i < arr_cnt; i++)
    free(arr[i]);
  free(arr);
}

void convert_to_roman(int num) {
  char r[] = {'I', 'V', 'X', 'L', 'C', 'D', 'M'};
  int v[] = {1, 5, 10, 50, 100, 500, 1000};
  char* basic[] = { "IIII", "VIIII", "XXXX", "LXXXX", "CCCC", "DCCCC" };
  char* modern[] = { "IV", "IX", "XL", "XC", "CD", "CM" };
  printf("Input: %d\n", num);
  char ans[100] = {};
  int ans_len = 0;
  int stack[7];
  int i;
  for (i = 0; i < sizeof(r) / sizeof(char); i++) 
    if (num >= v[i]) 
      stack[i] = v[i];
    else
      break;
  i--;
  while (i >= 0) {
    int x = stack[i];
    int d = num/x;
    for (int _j = 0; _j < d; _j++) {
      ans[ans_len] = r[i];
      ans_len++;
    }
    num -= d*x;
    i--;
  }
  int blen = sizeof(basic) / sizeof(char*);
  char** answer = malloc((blen + 1)* sizeof(char*));
  answer[0] = malloc(9999 * sizeof(char));
  strncpy(answer[0], ans, ans_len);
  int ans_cnt = 1;
  for (int i = 0; i < blen; i++) {
    char* key = basic[blen - 1 - i];
    char* val = modern[blen - 1 - i];
    if (strstr(answer[ans_cnt-1], key) != NULL){
      answer[ans_cnt] = replace(answer[ans_cnt-1], key, val);
      ans_cnt++;
    }
  }
  printf("Output: %s\n", answer[ans_cnt-1]);
  for (int i = 0; i < ans_cnt; i++)
    free(answer[i]);
  free(answer);
}

int main() {
  convert_from_roman("CCXLVI");
  convert_to_roman(39);
}
