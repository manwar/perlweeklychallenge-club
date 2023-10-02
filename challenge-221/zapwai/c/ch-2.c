#include <stdio.h>
#include <math.h>

void dec_to_bin(int* binary_format, int length, int n) {
  int num[32] = {};
  int i = 0;
  while (n > 0) {
    num[i] = n % 2;
    n = n / 2;
    i++;
  }
  
  int diff = length - i;
  int k = 0;
  if (0 < diff) {
    if (diff < length) {
      binary_format[i] = 0;
      i++;
    }
    while (diff > 1) {
      diff--;
      k++;
      binary_format[i] = 0;
      i++;
    }
  }

  for (int j = i - 1; j >= 0; j--) {
    binary_format[j] = num[j - k];
  }
}

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

int longest_arit_subseq(int length, int *ints) {
  /* elements are included in the subseq based on a flag in bits*/
  int max=0;
  int winning_subseq[length];
  for (int seed=0; seed < pow(2, length); seed++) {
    int bits[length];
    for (int i=0; i < length; i++) {
      bits[i] = 0;
    }
    dec_to_bin(bits, length, seed);
    
    /* Create subsequence */
    int length_of_subseq = 0;
    for (int i=0; i < length; i++) {
      if (bits[i] == 1) {
	length_of_subseq++;
      }
    }

    if (length_of_subseq < 3) { continue; }
    int subseq[length_of_subseq];
    int j=0;
    for (int i=0; i < length; i++) {
      if (bits[i] == 1) {
	subseq[j] = ints[i];
	j++;
      }
    }

    /* Check subsequence for arithmeticity */
    int s = is_arit(length_of_subseq, subseq);
    if (s > max) {
      max = s;
      for (int k = 0; k < length_of_subseq; k++) {
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

int main () {
  int ints1[] = {9,4,7,2,10};
  int ints2[] = {3,6,9,12};
  int ints3[] = {20, 1, 15, 3, 10, 5, 8};
  int length1 = sizeof(ints1) / sizeof(ints1[0]);
  int length2 = sizeof(ints2) / sizeof(ints2[0]);
  int length3 = sizeof(ints3) / sizeof(ints3[0]);
  longest_arit_subseq(length1, ints1);
  longest_arit_subseq(length2, ints2);
  longest_arit_subseq(length3, ints3);
  return 0;
}
