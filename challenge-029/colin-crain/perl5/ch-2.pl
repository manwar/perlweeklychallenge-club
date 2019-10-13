#! /opt/local/bin/perl
#
#       c_function.pl
#
#       29 Task #2:
#           Write a script to demonstrate calling a C function. It could be any
#           user defined or standard C function.
#
#       method:
#           The easiest way to go about this is to use the module Inline::C. One still
#           may need some familiarity with perlapi and perhaps perlguts to interact smoothly
#           with Perl, but much less so than grappling directly with XS.
#
#           make_primes(  int num_primes, int quantity_asked  )
#               To demonstrate the use of a C function, we will first need
#               something that can really benefit from the added speed, in
#               this case a rewrite of the prime-finding by trial division
#               function last seen in PWC #23. This was rewritten in C with a
#               few more optimizations added, and further modified to return
#               a requested number of values at the end of a generated list
#               of a specified number of primes. So we pass in values for the
#               number of primes to generate and the number from the end of
#               that list to display. To produce this variable-length list of
#               values we will manually place the requested number of items
#               on the Stack to be returned by the function. (Alternately we
#               could insert them in a Perl array and return a reference)
#               Because we do this manually, the function itself returns type
#               void. Inline::C provides macros to perform this magic of
#               directly manipulating the Stack, which we employ in the
#               example. If we request more primes than we generate, rather
#               than return a short list we choose to return no elements at
#               all.
#
#               In this example we use the perlapi functions newSViv( int )
#               -- which creates a new SV integer value, and sv_2mortal( SV
#               ) which flags a variable for garbage collection when is no
#               longer needed to be around.
#
#           print_primes( *SV some_prime, ... ):
#               Once we have a list of requested primes, we might wish to examine
#               them in tabular form. This function takes a variable sized list of
#               integers and prints such a table to STDOUT.
#
#           usage: ./c_function.pl 2000000 10
#               This produces a table of the last 10 primes of a list of 2,000,000
#
#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

## fetch the number of primes to generate and the number requested to be displayed off the end of that list
my ($number_of_primes, $number_requested) = @ARGV;

print_primes( make_primes($number_of_primes, $number_requested) );

use Inline C => <<'END_OF_C_CODE';
void make_primes(  int num_primes, int quantity_asked  ) {
/* returns array of Perl SV*s on the Stack,
   the quantity_asked number of primes from the
   end of a generated list of primes num_primes long.
   The unreturned primes are not kept. */

/* the bool type seems to already be defined somewhere in the headers
   loaded by Inline::C so this does not appear to be strictly required. */
    #include <stdbool.h>

/* initialize variables associated with accessing the Stack */
    Inline_Stack_Vars;

/* reset the stack pointer before we push output data to it */
    Inline_Stack_Reset;

/* if the number of primes requested is greater than the number generated, fail and return (-1) */
    if ( quantity_asked > num_primes ) {
        Inline_Stack_Push( sv_2mortal(newSViv( -1 )) );

/* make sure we call this to wrap up the stack */
       Inline_Stack_Done;
        return;
    }

/* we will only push the first prime, 2 on if it will be required in the requested number of values to be returned */
    if ( quantity_asked == num_primes ) {

/* if yes, to push the integer 2 on the Stack and start the prime list. We first cast it into a
   Perl SV, then mark it as "mortal", to be collected as once copied to the Stack it is no longer
   necessary and if allowed to remain will leak memory */
        Inline_Stack_Push( sv_2mortal(newSViv( 2 )) );
    }


    int candidate;
    int count = 0;
    for(  candidate = 3;  count <= (num_primes - 2);  candidate += 2  ) {
        int sqrt_candidate = sqrt( candidate );
        bool is_prime = true;
        int test;
        for(  test = 3; ( test <= sqrt_candidate ) && ( is_prime == 1 ); test += 2  ) {
            if(  candidate % test == 0  ) {
                is_prime = false;
            }
        }
        if( is_prime == true ) {
            count++;

            if (count > num_primes - (quantity_asked + 1) ) {

                /* as above, we need to first cast data as a Perl SV* type,
                    then label it mortal for collection after it is copied over to the Stack*/
                Inline_Stack_Push( sv_2mortal(newSViv( candidate )) );
            }
        }
    }

    /* make sure we call this to wrap up the Stack */
    Inline_Stack_Done;
}

void print_primes ( SV* some_prime, ... ){
/* given a varible length list of primes, prints out a nice little enumerated table of the primes requested */

/* initialize variables associated with accessing the Stack */
    Inline_Stack_Vars;

    int idx;
    int count = 1;

    printf("request #    |     prime\n");
    printf("-------------+-----------\n");

/* Inline_Stack_Items contains the number of values on the Stack */
/* Inline_Stack_Item(idx) contains the value at that index  */
/* SvIV coerces an SV* into a integer value */
    for (idx = 0; idx < Inline_Stack_Items; idx++, count++) {
        printf("%5d        |   %7d\n", count, SvIV( Inline_Stack_Item(idx) ));
    }

 /* null out any data in the Stack */
    Inline_Stack_Void;

/* make sure we call this to wrap up the Stack */
    Inline_Stack_Done;
}

END_OF_C_CODE
