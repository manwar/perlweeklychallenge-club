/*
part.c
Prints the number P(n) of ways of partitioning a non-negative integer n into
increasing or decreasing serieses of positive integers.
For example, 5 may be partitioned in these (and ONLY these) 7 ways:
5 = 5
5 = 4 + 1
5 = 3 + 2
5 = 3 + 1 + 1
5 = 2 + 2 + 1
5 = 2 + 1 + 1 + 1
5 = 1 + 1 + 1 + 1 + 1
Hence P(5)=7.

Note: The algorithm for this program is taken from the "Recurrence Relations" section of this web site:
https://en.wikipedia.org/wiki/Partition_function_(number_theory)

Note: "partitions" is nearly identical to my program "part", except that it prints P(i) for ALL values of i from 1
through the given argument n. "partitions" is a trivial extention of "part", because "part" already calculates all of
those numbers anyone, but only prints P(n).

Written by Robbie Hatley on Wednesday April 4, 2018.

Edit History:
2018-04-04: Wrote it.
2022-07-16: Dramatically-improved comments.
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <gmp.h>

// Set maximum number of partitions, then set array size to 5 over that:
#define MAX_N 1000000
#define ARRAY_SIZE (MAX_N + 5)

mpz_t PTable [ARRAY_SIZE];

// Initialize first TopOfZone elements of PTable, and set the value of the first 10 elements manually:
void InitPTable (int TopOfZone)
{
   int i = 0;

   if (TopOfZone <   10 ) TopOfZone = 10;
   if (TopOfZone > MAX_N) TopOfZone = MAX_N;

   // Only initialize the elements we actually need:
   for ( i = 0 ; i <= TopOfZone ; ++i )
   {
      mpz_init(PTable[i]);
   }

   // Insert #s of partitions for n in 0-10 range manually:
   mpz_set_si(PTable[ 0],  1);
   mpz_set_si(PTable[ 1],  1);
   mpz_set_si(PTable[ 2],  2);
   mpz_set_si(PTable[ 3],  3);
   mpz_set_si(PTable[ 4],  5);
   mpz_set_si(PTable[ 5],  7);
   mpz_set_si(PTable[ 6], 11);
   mpz_set_si(PTable[ 7], 15);
   mpz_set_si(PTable[ 8], 22);
   mpz_set_si(PTable[ 9], 30);
   mpz_set_si(PTable[10], 42);
}

// Inline the "Generalized Pentagonal Numbers" function
// by making it a function-like macro (metaprogramming):
#define Pent(X) ((X)*(3*(X)-1)/2)

void NumberOfPartitions (mpz_t result, const int n)
{
   if      (n <   0) {mpz_set_si(result,   0     );}
   else if (n ==  0) {mpz_set_si(result,   1     );}
   else if (n <= 10) {mpz_set   (result,PTable[n]);}
   else//if(n >= 11):
   {
      int    m       = 0;
      int    LwrLim  = 0;
      int    UprLim  = 0;
      int    k       = 0;
      mpz_t  Term;   mpz_init(Term);
      mpz_t  p;      mpz_init(p);

      // We already have the partition numbers for 0-10, so
      // now lets build up the table, starting from 11 and
      // working up to m. This way, no recursion is required.
      for ( m = 11 ; m <= n ; ++m )
      {
         LwrLim = (int) ceil  (-(sqrt(24.0*m+1.0)-1.0)/6.0);
         UprLim = (int) floor ( (sqrt(24.0*m+1.0)+1.0)/6.0);
         // printf("m = %d  LwrLim = %d  UprLim = %d\n", m, LwrLim, UprLim);
         // Zero p here, because we're starting a new partition
         // (otherwise p accumulates junk from earlier partitions):
         mpz_set_si(p, 0);
         for ( k = LwrLim ; k <= UprLim ; ++k )
         {
            if (0 == k) continue;
            if (m-Pent(k) < 0)
            {
               fprintf(stderr, "m-Pent(k) < 0\n");
               continue;
            }
            mpz_set(Term, PTable[m-Pent(k)]);
            if (0 == k%2)
            {
               mpz_sub(p, p, Term);
            }
            else
            {
               mpz_add(p, p, Term);
            }
         }
         mpz_set(PTable[m], p);
      } // end for each m
      // Set "result" to nth element of table:
      mpz_set(result, PTable[n]);
   } // end else (n >= 11)
   // Return. (Since we're passing the output in the "result" parameter,
   // there's no return value.)
   return;
}

int main (int Beren, char * Luthien[])
{
   // Declare any necessary variables:
   long    n_raw  = 0L;
   int     n      = 0;
   mpz_t   p;

   // Do all necessary preliminary book-keeping:
   mpz_init(p);
   if (Beren != 2)
   {
      fprintf
      (
         stderr, 
         "Error: \"part\" requires exactly 1 argument, which must be\n"
         "a non-negative integer not exceeding %d.\n",
         MAX_N
      );
      exit(666);
   }
   n_raw = strtol(Luthien[1], NULL, 10);
   if (n_raw > MAX_N || n_raw < 0)
   {
      fprintf
      (
         stderr, 
         "Error: argument must be a non-negative integer\n"
         "not exceeding %d\n", 
         MAX_N
      );
      exit(666);
   }

   // n is the number to be partitioned, and is also the number of possible numbers of stacks, as any positive integer n
   // will have partitions including all numbers of stacks from 1 through n:
   n = (int)n_raw;  

   // Initialize the first n elements of PTable, and set the value of the first 10 elements manually to
   // P(n) for n values from 1 through 10:
   InitPTable(n);

   // With the preliminaries out of the way, let's get to calculating and printing P(n):
   NumberOfPartitions(p, n); // Calculate P(n).
   gmp_printf("%Zd", p);     // Print P(n).
   return 0; 
}
