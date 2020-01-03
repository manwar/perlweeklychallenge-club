use strict;
use warnings;
use feature qw /say/;

my @leonardo = (1, 1);
sub leonardo {
    my $in = shift;
    return $leonardo[$in] if defined $leonardo[$in];
    $leonardo[$in] = 1 + leonardo($in - 1) + leonardo($in -2);
}
my $target = leonardo(shift);
say "@leonardo";
