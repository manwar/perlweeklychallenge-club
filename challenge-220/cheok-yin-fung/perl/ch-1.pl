# The Weekly Challenge 220
# Task 1 Common Characters
use v5.30.0;
use warnings;
use Set::Scalar;

sub cc {
    my @words = @_;
    @words = map {lc} @words;
    my $first_w = shift @words;
    my $ccs = Set::Scalar->new(split "", $first_w);
    for my $w (@words) {
        my $cs = Set::Scalar->new(split "", $w);
        $ccs = $ccs->intersection($cs);
    }
    return [sort {$a cmp $b} $ccs->elements];

}

use Test::More tests=>3;
use Test::Deep;
cmp_deeply cc("Perl", "Rust", "Raku"), ["r"];
cmp_deeply cc("love", "live", "leave"), ["e", "l", "v"];
use utf8;
ok (Set::Scalar->new(cc("一石二鳥", "一二三四")->@*)->is_equal(Set::Scalar->new("一", "二")));

