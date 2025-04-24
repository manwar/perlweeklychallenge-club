use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($string) {
    my $result = [];
    my $last = undef;
    my @string = split //, $string;
    my @parts;

    for (my $i = 0; $i < scalar(@string); $i++) {
        if (! defined $last || $last ne $string[$i]) {
            push @parts, '';
        }
        $last = $string[$i];
        $parts[-1] .= $last;
    }
    return [ grep { length($_) >  2} @parts ];
}

is_deeply(run("abccccd"), ["cccc"], "Example 1");
is_deeply(run("aaabcddddeefff"), ["aaa", "dddd", "fff"], "Example 2");
is_deeply(run("abcdd"), [], "Example 3");
