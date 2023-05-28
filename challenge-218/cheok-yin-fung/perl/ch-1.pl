# The Weekly Challenge 218
# Task 1 Maximum Product

use v5.30.0;
use warnings;
use List::Util qw/max/;

sub mp {
    my @old_list = @_;
    my @list = grep {$_ != 0} sort {$b<=>$a} @old_list;
    return 0 if scalar @list < 3;
    my $appp = $list[0]*$list[1]*$list[2];
    my $apnn = $list[0]*$list[-2]*$list[-1];
    #   my $appn = $list[0]*$list[1]*$list[2];
    #   my $annn = $list[0]*$list[1]*$list[2];
    return max($appp, $apnn);
}

use Test::More tests=>5;
ok mp(3, 1, 2) == 6;
ok mp(4, 1, 3, 2) == 24;
ok mp(-1, 0, 1, 3, 1) == 3;
ok mp(-8, 2, -9, 0, -4, 3) == 216;

ok mp(-4, -1, -3, -2) == -6;
