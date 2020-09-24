use strict;
use warnings;
use v5.20;

# get input array from command line

my @N = @ARGV;

die "usage: perl $0 <space separate numbers (at least 3)>" unless @N > 2;

# check that all  numbers are positive, and find max value

my $max = -1;
for my $n (@N) {
  die "$n is not a proper positive number" unless $n && $n =~ /^\d+$/;
  $max = $n if $n > $max;
}

# we need to take care of the amount of decimal places needed
# form $max, so the histogram can look ok

my $places = length $max;

# so the format to print numbers should be:

my $dfmt = "\%${places}d";

my $acc_water = 0;

for my $r (reverse 1 .. $max) {

  # construct horizontal row, starting from $max
  my $line = join('', map { $_ >= $r ? '#' : ' ' } @N);

  # we need to identify in this particular line how many units
  # of rain water we can trap. We will replace with a "W" every
  # one of those units.
  #
  # We search for the pattern #< n spaces>#, and as this will
  # allow to trap n units, we will replace the spaces with the
  # letter "W"

  # Note that after replacing one group, we should start over the
  # same line. We cannot continue looking because the last caracter
  # matched ('#') may be necesary for the next match. So we cannot
  # use a /g to repeat the search, we need to start over the
  # matching, but with the spaces changed to "W" so we don't get
  # the same match but the following one, if any.

  # For the regex, we use substitution (s///) and we calculate
  # the replacement with "W" x length(spaces captured), and leave
  # the '#'s in place. /e means we are evaluating the second
  # argument, instead of taking it literally
  #
  while ($line =~ s/#(\s+)#/'#'. 'W' x length($1) . '#'/e) { }

# units this row can trap is the amount of "W"s we have on it
# feel free to change the transliteration operator to tr/W/W/
# to keep an indication of the allocated water units
  $acc_water += $line =~ tr/W/ /;

  # we will add separating spaces between symbols, note we do that after any
  # calculation
  $line = ' ' . join(' ', split('', $line));
  say sprintf($dfmt, $r) . $line;
}

# closing line
say " " x ($places - 1) . '_' . ' _' x @N;

# now print the base rows of the histogram

for my $i (0 .. $places - 1) {
  my $line = join(' ', map { substr(sprintf($dfmt, $_), $i, 1) } @N);
  say " " x ($places + 1) . $line;
}

say "Trapped water: $acc_water";
