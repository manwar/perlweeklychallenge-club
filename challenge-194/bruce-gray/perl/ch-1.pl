use v5.36;
use List::Util qw<first>;

sub task1 ($s) {
    state %VALID_TIMES = map { my $m = $_; map {; "$_:$m" => 1 } '00'..'23' } '00'..'59';

    return first { $VALID_TIMES{ $s =~ s/\?/$_/r } } reverse 0..9;
}


my @tests = (
    [ '?5:00', 1 ],
    [ '?3:00', 2 ],
    [ '1?:00', 9 ],
    [ '2?:00', 3 ],
    [ '12:?5', 5 ],
    [ '12:5?', 9 ],
);
use Test::More;
plan tests => 0+@tests;
for (@tests) {
    my ($in, $expected) = @{$_};
    is task1($in), $expected, "task1($in) == $expected";
}
