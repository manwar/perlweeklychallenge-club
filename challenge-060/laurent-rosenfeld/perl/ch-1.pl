use strict;
use warnings;
use feature qw /say/;
use constant MAXNUM => 16_384;
use constant MAXLET => 'XFD';

my @cols = ('', 'A'..MAXLET);
my %nums = map { $cols[$_] => $_ } 1..MAXNUM;
my $in = shift // 28;
if ($in =~ /^\d+$/) {
    say "Column $in = $cols[$in]";
} elsif ( $in =~ /^[A-Z]+$/ ) {
    say "Column $in = $nums{$in}";
} else {
    say "$in is invalid input.";
}
