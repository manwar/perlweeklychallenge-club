use strict;
use warnings;
use feature qw /say/;

sub count_words {
    my $prefix = shift;
    return scalar grep { substr($_, 0, length $prefix)
        eq $prefix } @_;
}
for my $test ( [<at pay attention practice attend>],
               [<ja janet julia java javascript>] ) {
    my @t = @$test;
    printf "%-3s - %-30s => ",
        $t[0], "@t[1..$#t]";
    say count_words @t;
}
