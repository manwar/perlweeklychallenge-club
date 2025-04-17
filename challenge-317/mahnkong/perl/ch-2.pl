use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub get_string_diff($str1, $str2) {
    my $diffs = 0;
    for (my $i = 0; $i < scalar(@$str1); $i++) {
        $diffs += 1 if ($str1->[$i] ne $str2->[$i]);
    }
    return $diffs;
}

sub run($str1, $str2) {
    my @str1 = split //, $str1;
    my @str2 = split //, $str2;
    return 0 if get_string_diff(\@str1, \@str2) > 2;
    return join('', sort { $a cmp $b } @str1) eq join('', sort { $a cmp $b } @str2) || 0;
}

is(run("desc", "dsec"), 1, "Example 1");
is(run("fuck", "fcuk"), 1, "Example 2");
is(run("poo", "eop"), 0, "Example 3");
is(run("stripe", "sprite"), 1, "Example 4");
is(run("aaaabb", "bbaaaa"), 0, "Example 5");
