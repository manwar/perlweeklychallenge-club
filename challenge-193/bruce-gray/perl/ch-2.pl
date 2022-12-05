use v5.36;
use List::Util       qw<mesh pairvalues>;
use List::MoreUtils  qw<slide>;
use List::Categorize qw<categorize>;

sub diffs ( $s ) {
    state %A_N = mesh ['a'..'z'], [0..25];

    return join ':',
           slide { $b - $a }
           @A_N{ split '', $s };
}
sub oddballs ( @s ) {
    return grep { @{$_} == 1 } 
           pairvalues
           categorize { diffs($_) } @s;
}
sub task2 ( @s ) {
    my @r = oddballs(@s);
    warn if @r != 1;
    return $r[0][0];
}


my @tests = (
    [ 'abc', qw<adc wzy abc    > ],
    [ 'bob', qw<aaa bob ccc ddd> ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ( $expected, @input ) = @{$_};
    is task2(@input), $expected;
}
