#include <stdio.h>
#include <string.h>

void arrange(char word[], int wordlen) {
  char newword[100] = {};
  for (int i = 0; i < wordlen; i++)
    newword[i] = word[i];
  int cnt = 1;
  while (cnt > 0) {
    cnt = 0;
    for (int i = 0; i < wordlen - 1; i++)
      if (newword[i] > newword[i+1]) {
	cnt++;
	char let = newword[i];
	newword[i] = newword[i+1];
	newword[i+1] = let;
      }
  }
  for (int i = 0; i < wordlen; i++) 
    printf("%c", newword[i]);
}

void proc(char mystr[], int mystrlen, char mychar) {
  printf( "Input: mystr = %s, char = %c\n", mystr, mychar);
  char *e;
  e = strchr(mystr, mychar);
  int ind = (int)(e - mystr);
  if (e == NULL) {
    printf( "Output: %s\n", mystr);
  } else {
    printf("Output: ");
    char begin[100] = {};
    for (int i = 0; i < ind + 1; i++)
      begin[i] = mystr[i];
    arrange(begin, sizeof(begin) / sizeof(char));
    for (int i = ind + 1; i < mystrlen; i++)
      printf("%c", mystr[i]);
    printf("\n");
  }
}

int main() {
  char mystr[] = "challenge";
  int mystrlen = sizeof(mystr) / sizeof(char);
  char mychar = 'e';
  proc(mystr, mystrlen, mychar);
  char mystr2[] = "programming";
  int mystrlen2 = sizeof(mystr2) / sizeof(char);
  char mychar2 = 'a';
  proc(mystr2, mystrlen2, mychar2);
  char mystr3[] = "champion";
  int mystrlen3 = sizeof(mystr3) / sizeof(char);
  char mychar3 = 'b';
  proc(mystr3, mystrlen3, mychar3);
}
