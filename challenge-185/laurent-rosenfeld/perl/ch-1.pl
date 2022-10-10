use strict;
use warnings;
use feature qw/say/;

for my $test ("1ac2.34f0.b1c2", "abc1.20f1.345a") {
    $_ = $test;
    s/\./:/g;
    s/(\w\w)(\w\w)/$1:$2/g;
    say;
}
