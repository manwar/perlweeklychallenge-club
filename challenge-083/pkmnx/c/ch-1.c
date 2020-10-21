#include <stdio.h>
#include <ctype.h>

int main() {

   char c;
   char state;

   long tot = 0;
   long acc = 0;
   long c_cnt = 0;

   while ( (c = getchar()) != EOF ) {

      if ( isspace(c) ) {
         state = 's';
      } else {
         state = state == 's' ?'c' :'w';
         acc++;
      }

      if ( c_cnt >= 1 ) {
         tot += state == 'c' ?acc : 0;
      }

      if ( state == 'c' ) {
         c_cnt++;
         acc = 0;
      }

   }

   printf( "%ld\n", tot );

   return 0;

}
