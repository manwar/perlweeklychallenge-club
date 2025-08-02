#include <stdio.h>
void proc(char*, char*, int, int);
int main() {

  char s[] = "Perl";
  char t[] = "Preel";
  proc(s, t, sizeof(s)/sizeof(char), sizeof(t)/sizeof(char));

  char s2[] = "Weekly";
  char t2[] = "Weeakly";  
  proc(s2, t2, sizeof(s2)/sizeof(char), sizeof(t2)/sizeof(char));  

  char s3[] = "Box";
  char t3[] = "Boxy";  
  proc(s3, t3, sizeof(s3)/sizeof(char), sizeof(t3)/sizeof(char));  
  
}

void proc(char *s, char *t, int slen, int tlen)  {
  int fs[123] = {0};			/* entries 65 to 122 contain freqs of chars */
  int ft[123] = {0};  

  for (int i = 0; i < slen; i++) {
    fs[s[i]]++;
  }
  for (int i = 0; i < tlen; i++) {
    ft[t[i]]++;
  }

  int ansnum;
  for (int i = 0; i < 123; i++) {
    if ( (ft[i] == 1) && (fs[i] == 0) ) { ansnum = i; break; }
    else if ( ft[i] > fs[i] ) { ansnum = i; break; }
  }

  printf("Input: s: %s t: %s\nOutput: %c\n", s, t, ansnum);
}  