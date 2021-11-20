use strict;
use warnings;
use feature "say";

sub jortsort {
    my @in = @_;
    for my $i (1..$#in) {
        return 0 if $in[$i - 1] > $in[$i];
    }
    return 1;
}

for my $a ([1,2,3,4,5], [1,3,2,4,5]) {
    say "@$a -> ", jortsort @$a;
}
