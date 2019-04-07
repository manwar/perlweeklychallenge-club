# Challenge #1
#
# Write a script or one-liner to remove leading zeros from positive numbers.

## Using Perl 5:
while (<>) { # read positive number as lines from stdin
  s/^0+//; # remove leading zeros from each line
  print; # show updated number
}

## as a single shell one-liner:
# $ perl -E 'while(<>) {s/^0+//;print;}' # interactively reads numbers

# or pipe the numbers to format, example:
# $ cat numbers_list | perl -E 'while(<>) {s/^0+//;print;}'
