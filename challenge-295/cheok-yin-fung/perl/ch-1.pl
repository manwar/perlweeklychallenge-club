# The Weekly Challenge 295
# Task 1 Word Break

# a recursive solution, not a perfect solution :(

use v5.30;
use warnings;

sub wb {
    my $str = $_[0];
    my @words = $_[1]->@*;
    my $ans = 0;
    for my $w (@words) {
        my $b;
        if (length $str > length $w && substr($str,0,length $w) eq $w) {
            $b = wb(substr($str,length $w), [@words]);
        }
        elsif ($str eq $w) {
            return 1;
        }
        $ans = $ans || $b;
    }
    return $ans;
}

use Test::More tests=>5;
ok wb("weeklychallenge", ["challenge", "weekly"]);
ok wb("perlrakuperl", ["raku", "perl"]);
ok !wb("sonsanddaughters", ["sons", "sand", "daughters"]);
ok !wb("abcdefghijklmn", ['a'..'m']);
ok !wb("abcdefghijklmn", ['b'..'n']);
