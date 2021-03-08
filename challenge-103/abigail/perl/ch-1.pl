#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#
# We're reading years from standard input, one year per line, outputting
# years from the sexagenary cycle [1]. This is slightly more than what
# the challenge ask; the challenge asks to output the heavenly stem [2],
# and the earthly branch [3]. But we also output its Yin/Yang.
#
# [1] https://en.wikipedia.org/wiki/Sexagenary_cycle
# [2] https://en.wikipedia.org/wiki/Heavenly_Stems
# [3] https://en.wikipedia.org/wiki/Earthly_Branches
#

#
# Each of the cycles have been rotated so the first entry corresponds to
# the year 0 in the Proleptic Gregorian calendar. (We're using the
# convention of having a year 0, as per ISO 8601).
# That way, we can just mod the year with the number of entries, without
# first having to subtract something from the year.
#
# The heavenly stems last for 2 years, so we just duplicate the entries.
#

my $yin_yang         = [qw [Yang Yin]];
my $heavenly_stems   = [map {($_) x 2} qw [Metal Water Wood Fire Earth]];
my $earthly_branches = [qw [Monkey  Rooster  Dog    Pig   Rat    Ox
                            Tiger   Rabbit   Dragon Snake Horse  Goat]];


while (my $year = <>) {
    $, = " ";
    say map {$$_ [$year % @$_]} $yin_yang, $heavenly_stems, $earthly_branches;
}


__END__
