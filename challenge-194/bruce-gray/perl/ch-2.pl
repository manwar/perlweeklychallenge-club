use v5.36;
use List::Util qw<uniq>;

# Translation of my Raku solution.
sub task2 ($s) {
    my %h;
    $h{$_}++ for split '', $s;
    my @k = keys %h;

    for my $k (@k) {
        $h{$k}--;

        my $c = 0 + grep { $_ != 0 } uniq values %h;

        return 1 if $c == 0
                 or $c == 1;

        $h{$k}++;
    }
    return 0;
}


my @tests = (
    [ 'abbc'    , 1 ], # Removing one alphabet 'b' will give us 'abc' where each alphabet frequency is the same.
    [ 'xyzyyxz' , 1 ], # Removing 'y' will give us 'xzyyxz'.
    [ 'xzxz'    , 0 ], # Removing any one alphabet would not give us string with same frequency alphabet.

    # True if there is one of each character
    [ 'abcdefg' , 1 ],
    [ 'ab'      , 1 ],
    [ 'a'       , 1 ],

    [ 'aabbccdd' , 0 ],  # False if there is >one of each character; same of all:
    [ 'aa'       , 1 ],  # True  if there is >one of each character; 1group     :

    [ 'aaabbbcccc', 1 ],
    [ 'aaabbbcc'  , 0 ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ($in, $expected) = @{$_};
    is task2($in), $expected, "task2($in) == $expected";
}
