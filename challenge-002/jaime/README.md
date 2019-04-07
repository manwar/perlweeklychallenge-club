# Perl Weekly Challenge 002
By Jaime; @tortsnare on Twitter.

Straightforward solutions in Perl 5 that use no imports.
The user selects a conversion and feeds in numbers, in a UNIX-like approach.

# perl5/ch-1.pl
Write a script or one-liner to remove leading zeros from positive numbers.

## Solution
Run as a single shell one-liner:
`perl -E 'while(<>) {s/^0+//;print;}' # interactively reads numbers`

or pipe the numbers, example:
`cat number_list | perl -E 'while(<>) {s/^0+//;print;}`

# perl5/ch-2.pl
Write a script that can convert integers to and from a base35 representation,
using the characters 0-9 and A-Y.

## Solution
Convert between base10 and base35 strings.
User flags toggle the conversion operation at runtime.

## Convert base10 into base35
`cat integer_list | perl ch-2.pl`

## Convert base35 into base10
`cat base35_list | perl ch-2.pl --base35-to-int`
