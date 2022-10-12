use strict;
use warnings;
use feature qw/say/;

sub zip  {
    my @c = @{$_[0]};
    my @d = @{$_[1]};
    my $out = "";
    for my $i (0..$#c) {
        $out = $out . $c[$i] . " " . $d[$i] . " " ;
    }
    return $out;
}
my @tests = ([<1 2 3>], [<a b c>]);
say zip $tests[0], $tests[1];
say zip $tests[1], $tests[0];
