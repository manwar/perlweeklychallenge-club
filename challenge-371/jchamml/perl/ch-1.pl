use strict;
use warnings;
#You are given a sequence of 5 lowercase letters, with one letter replaced by
#‘?’. Each letter maps to its position in the alphabet (‘a = 1’, ‘b = 2’, …, ‘z
#= 26’). The sequence follows a repeating pattern of step sizes between
#consecutive letters. The pattern is either a constant step (e.g., ‘+2, +2, +2,
#+2’) or a simple alternating pattern of two distinct steps (e.g., ‘+2, +3, +2,
#+3’).
#

sub missing(@) {
    my @nbrs = map(ord ,@_);

    my $prior = 0;
    my $gap=0;
    my @gaps = map {
        $gap = $_ - $prior;
        $prior=$_;
        $gap == $_ ? () : $gap;
    } grep {$_ != 63} @nbrs;

    if ($nbrs[0] == 63) {return chr($nbrs[1] - $gaps[1])};
    if ($nbrs[1] == 63) {return chr($nbrs[0] + $gaps[1])};
    if ($nbrs[2] == 63) {return chr($nbrs[1] + $gaps[2])};
    if ($nbrs[3] == 63) {return chr($nbrs[2] + $gaps[0])};
    if ($nbrs[4] == 63) {return chr($nbrs[3] + $gaps[1])};
}

my @seq = qw(a c ? g i);
my $char = missing(@seq);
print "the missing letter in (@seq) is $char\n";

@seq = qw(a d ? j m);
$char = missing(@seq);
print "the missing letter in (@seq) is $char\n";

@seq = qw(a e ? m q);
$char = missing(@seq);
print "the missing letter in (@seq) is $char\n";

@seq = qw(a c f ? k);
$char = missing(@seq);
print "the missing letter in (@seq) is $char\n";

@seq = qw(b e g ? l);
$char = missing(@seq);
print "the missing letter in (@seq) is $char\n";

