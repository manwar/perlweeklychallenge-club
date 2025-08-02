use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($str1, $str2) {
    my %lookup = map { $_ => 1 } @$str2;
    foreach my $str (@$str1) {
        delete $lookup{$str} if exists $lookup{$str};
    }
    return scalar(@$str2) - scalar(keys(%lookup));
}

is_deeply(run(["perl", "weekly", "challenge"], ["raku", "weekly", "challenge"]), 2, "Example 1");
is_deeply(run(["perl", "raku", "python"], ["python", "java"]), 1, "Example 2");
is_deeply(run(["guest", "contribution"], ["fun", "weekly", "challenge"]), 0, "Example 3");
