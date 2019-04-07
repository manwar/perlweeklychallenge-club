# Perl Weekly Challenge 002
By Jaime; @tortsnare on Twitter.

Straightforward solutions in Perl 5 that use no imports.
The user selects a conversion and feeds in numbers, in a UNIX-like approach.

The faniest bit was an `eval` introduced at the end to toggle the conversion operation at runtime.

# ch-1.pl

Run as a single shell one-liner:
`perl -E 'while(<>) {s/^0+//;print;}' # interactively reads numbers`

or pipe the numbers, example:
`cat number_list | perl -E 'while(<>) {s/^0+//;print;}`

# ch-2.pl
Run as a Perl 5 script.

## Convert base10 into base35

`cat integer_list | perl ch-2.pl`

## Convert base35 into base10

`cat base35_list | perl ch-2.pl --base35-to-int`
