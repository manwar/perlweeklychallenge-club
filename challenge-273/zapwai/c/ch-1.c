#include <stdio.h>
#include <string.h>

void proc(char* mystr, char mychar) {
  printf( "Input: str = %s, char = %c\n", mystr, mychar);
  int cnt = 0;
  for (int i = 0; i < strlen(mystr); i++)
    if (mystr[i] == mychar)
      cnt++;
  int inty = 100*((float) cnt / strlen(mystr));
  float r = 100*((float) cnt / strlen(mystr)) - inty;
  if (r >= .5)
    inty++;
  printf("Output: %d\n", inty);
}

int main() {
  char* mystr = "perl";
  char mychar = 'e';
  proc(mystr, mychar);
  mystr = "java"; mychar = 'a';
  proc(mystr, mychar);
  mystr = "python"; mychar = 'm';
  proc(mystr, mychar);
  mystr = "ada"; mychar = 'a';
  proc(mystr, mychar);
  mystr = "ballerina"; mychar = 'l';
  proc(mystr, mychar);
  mystr = "analitik"; mychar = 'k';
  proc(mystr, mychar);    
}

