use strict;
use warnings;
use feature qw/say/;

sub move_zero {
    return ((grep $_ != 0, @_), grep $_ == 0, @_);
}
for my $test ([<1 0 3 0 0 5>], [<1 6 4>], [<0 1 0 2 0>]){
    say "@$test => \t", join " ", move_zero  @$test;
}
