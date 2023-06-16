#include <stdio.h>
#include <math.h>
#include <string.h>
/* Return length of array if it is an arithmetic sequence,
   otherwise return 0 */
int is_arit (int length, int seq[]) {
  int k = seq[1] - seq[0];
  int cnt = 0;
  for (int i=1; i <= length - 2; i++) {
    if (seq[i+1] - seq[i] == k) {
      cnt++;
    }
    else {
      return 0;
    }
  }
  if (cnt == length - 2) {
    return length;
  }
  else {
    return 0;
  }
}

int main () {
  int ints[] = {9,4,7,2,10};
  /* int ints[] = {3,6,9,12}; */
  /* int ints[] = {20, 1, 15, 3, 10, 5, 8};   */
  int length = sizeof(ints) / sizeof(ints[0]);
  char bits[length];  
  /* elements are included in the subseq based on a flag in bits*/
  int max=0;
  int winning_subseq[length];
  /* # of possible digits in the arrays (ints) length (covers up to 999) */
  int num_digits = 3;
  char len[num_digits];
  sprintf(len, "%d", length);
  char a[num_digits + 5];
  strncpy(a,"%0",2);
  strncat(a,len,num_digits);
  strncat(a,"b",2);
  char form[num_digits + 5];
  sprintf(form, "%s", a);
  for (int seed=0; seed < pow(2, length); seed++) {
    sprintf(bits, form, seed);
    /* Create subsequence */
    int length_of_subseq = 0;
    for (int i=0; i < length; i++) {
      if (bits[i] == '1') {
	length_of_subseq++;
      }
    }

    if (length_of_subseq < 3) { continue; }
    int subseq[length_of_subseq];
    int j=0;
    for (int i=0; i < length; i++) {
      if (bits[i] == '1') {
	subseq[j] = ints[i];
	j++;
      }
    }

    /* Check subsequence for arithmeticity */
    int s = is_arit(length_of_subseq, subseq);
    if (s > max) {
      max = s;
      for (int k = 0; k < max; k++) {
	winning_subseq[k] = subseq[k];
      }
    }
  }
  printf("Input: @ints = (");
  for (int k = 0; k < length - 1; k++) {
    printf("%d,", ints[k]);
  }
  printf("%d)\n", ints[length-1]);
  printf("Output: %d\n", max);
  printf("\t(");
  for (int k = 0; k < max - 1; k++) {
    printf("%d,", winning_subseq[k]);
  }
  printf("%d)\n", winning_subseq[max - 1]);
  return 0;
}

