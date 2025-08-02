use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

my %chars;
my $num = 1;
foreach my $c ("a" .. "z") {
    $chars{$c} = $num;
    $num+=1;
}
my $num_chars = scalar(keys(%chars));

sub run($str) {
    my $current_char = 'a';
    my $seconds = 0;
    foreach my $t (split //, $str) {
        my $move_seconds = abs($chars{$t} - $chars{$current_char});
        if ($move_seconds > $num_chars/2) {
            $move_seconds = $num_chars - $move_seconds;
        }
        $seconds += $move_seconds;
        $current_char = $t;
    }
    $seconds += length($str);
    return $seconds;
}

is(run("abc"), 5, "Example 1");
is(run("bza"), 7, "Example 2");
is(run("zjpc"), 34, "Example 3");
