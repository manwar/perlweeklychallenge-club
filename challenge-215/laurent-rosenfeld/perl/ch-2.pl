use strict;
use warnings;
use feature 'say';

sub find_zeros {
    my @in = @{$_[0]};
    my $count = $_[1];
    return 0 if $count == 0 or @in < $count;
    my $str = join "", @in;
    return 1 if $str =~ /(?<!1)0{$count}(?!1)/;
    0;
}

for my $test ([<0 0 0 1>], [<0 0>], [<1 0 0 1>], [<1 0 0 0 1>],
         [<1 0 0 0 0 0 0 1>]) {
    for my $cnt (0..5) {
        printf "%d - %-16s => ", $cnt, "@$test";
        say find_zeros $test, $cnt;
  }
}
