/*
===============================================================================

         FILE: 11602.c

        USAGE: gcc 11602.c -lm && ./a.out N

  DESCRIPTION: Is the sum of the squares of the digits a square? 1 for
               yes, 0 for no.

       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
 ORGANIZATION: Openstrike
      VERSION: 1.0
      CREATED: 10/06/21
===============================================================================
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main (int argc, char **argv) {
	int ssd   = 0;
	int n     = atoi(argv[1]);

	/* Build the sum of the squares of the digits */
	while (n) {
		ssd += (n % 10) * (n % 10);
		n /= 10;
	}

	/* Check it is a square or not */
	n = sqrt (ssd);
	n *= n;
	printf ("%i\n", n == ssd);
	return (0);
}
