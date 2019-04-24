# Perl Weekly Challenge - 004
# Challenge #1
#
# See
#     engineering.purdue.edu/~mark/pwc-004.pdf
# for more information.

# Run using Perl 6.
use v6;

sub plouffe (Int $k)
{
    (1.FatRat/16**$k) *
    (
          (4 / (8*$k + 1))
        - (2 / (8*$k + 4))
        - (1 / (8*$k + 5))
        - (1 / (8*$k + 6))
    )
}

# Get size of the script.
my $size = $*PROGRAM-NAME.IO.s;

# The value of pi has only been double
# checked up to 1000 characters.
if ($size > 1_000)
{
    die "program not tested for a "
        ~ "script size of more than "
        ~ "1000 characters";
}
    
my $pi = [+] (plouffe $_ for 0..$size);

say substr($pi, 0, $size);
