#include <string.h>
#include <ctype.h>

char *upper_string(char s[])
{
  int c = 0;
  static char string[1000];
 
  while (s[c] != '\0')
  {
    string[c] = toupper(s[c]);
    c++;
  }
  string[c] = '\0';
  return string;
}
