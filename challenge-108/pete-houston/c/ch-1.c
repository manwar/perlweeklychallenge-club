/*
===============================================================================

         FILE: 10801.c

        USAGE: gcc 10801.c && a.out

  DESCRIPTION: Store a scalar and print the memory address of it

       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
 ORGANIZATION: Openstrike
      VERSION: 1.0
      CREATED: 16/04/21
===============================================================================
*/

#include <stdio.h>

int main () {
	int i = 5;
	printf ("i is stored at address 0x%x\n", &i);
	return (0);
}
