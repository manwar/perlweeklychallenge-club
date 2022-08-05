use strict;
use warnings;
use feature qw/say/;

sub check_multiples {
    my $j = shift;
    my $ordered = join '', sort split //, $j;
    for my $k (2..6) {
        return 0 if $ordered ne join '', sort {$a cmp $b}  split //, ($k * $j);
    }
    return 1;
}

my $i = 1;
while (1) {
    if (check_multiples $i) {
        say $i;
        last;
    }
    $i++;
}
