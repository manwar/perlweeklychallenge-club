/* vim:set ts=4 sw=4 sts=4 et ai wm=0 nu: */
/*****************************************************************************
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 375 Task 2  Find K-Beauty
#=============================================================================
# You are given a number and a digit (k).  Write a script to find the K-Beauty
# of the given number. The K-Beauty of an integer number is defined as the
# number of substrings of given number when it is read as a string has length
# of ‘k’ and is a divisor of given number.
# Example 1 Input: $num = 240, $k = 2
#           Output: 2
#   Substring with length 2:
#   24: 240 is divisible by 24
#   40: 240 is divisible by 40
#
# Example 2 Input: $num = 1020, $k = 2
#           Output: 3
#   Substring with length 2:
#   10: 240 is divisible by 10
#   02: 240 is divisible by 02
#   20: 240 is divisible by 20
#
# Example 3 Input: $num = 444, $k = 2
#           Output: 0
#   Substring with length 2:
#   First "44": 444 is not divisible by 44
#   Second "44": 444 is not divisible by 44
#
# Example 4 Input: $num = 17, $k = 2
#           Output: 1
#   Substring with length 2:
#   17: 17 is divisible by 17
#
# Example 5 Input: $num = 123, $k = 1
#           Output: 2
#   Substring with length 1:
#   1: 123 is divisible by 1
#   2: 123 is not divisible by 2
#   3: 123 is divisible by 3
*****************************************************************************/

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

void usage(char *progname)
{
    fprintf(stderr, "Usage: %s -k K num [num...]", progname);
}

int findK(char *numStr, int k)
{
    int length = strlen(numStr);
    assert( k <= length );

    int n = atoi(numStr);

    char *num = malloc(length+1);
    strcpy(num, numStr);

    int beauty = 0;
    char *end = num + length;
    char *beg = end - k;

    do {
        int sub = atoi(beg);
        if ( n % sub == 0 ) { beauty++; }

        *--end = '\0';
    } while ( --beg >= num );

    free(num);
    return beauty;
}


/****************************************************************************/
int main(int argc, char *argv[])
{
    int K = 1;

    int ch;
    while ( (ch = getopt(argc, argv, "k:")) != -1 )
    {
        switch (ch)
        {
        case  'k':
            K = atoi(optarg);
            break;
        case '?':
        default:
            usage(argv[0]);
            exit(1);
            break;
        }
    }

    fprintf(stderr, "After getopt, K=%d argc=%d\n", K, argc);

    for ( int n = optind; n < argc; n++ )
    {
        printf("%s %d\n", argv[n], findK(argv[n], K) );
    }

    exit(0);
    return 0;
}
