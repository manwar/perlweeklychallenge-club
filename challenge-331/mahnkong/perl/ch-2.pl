use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub check_buddy_string($ref, $compare_string, $i, $c_index) {
    my @s = @{$ref};
    my $c = $s[$i];
    my $o = $s[$c_index];
    $s[$i] = $o;
    $s[$c_index] = $c;
    return 1 if ($compare_string eq join('', @s));
}

sub run($str1, $str2) {
    return 0 if (length($str1) != length($str2)) || length($str1) == 0;

    my @str2 = split//, $str2;
    for (my $i = 0; $i <= $#str2; $i++) {
        return 1 if $i > 0 && check_buddy_string(\@str2, $str1, $i, $i-1);
        return 1 if $i < $#str2 && check_buddy_string(\@str2, $str1, $i, $i+1);
    }
    return 0;
}

is(run("fuck", "fcuk"), 1, "Example 1");
is(run("love", "love"), 0, "Example 2");
is(run("fodo", "food"), 1, "Example 3");
is(run("feed", "feed"), 1, "Example 4");
