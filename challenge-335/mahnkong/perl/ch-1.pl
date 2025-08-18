use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@words) {
    return undef unless scalar(@words);

    my %occurences;
    my @result;

    foreach my $c (split //, $words[0]) {
        if (! exists($occurences{$c})) {
            my $max_occurences_all;
            foreach my $word (@words) {
                my $occurences = () = $word =~ /$c/gi;
                $max_occurences_all = $occurences if (!defined $max_occurences_all || $max_occurences_all > $occurences);
            }
            $occurences{$c} = $max_occurences_all;
        } else {
            $occurences{$c} -= 1 if $occurences{$c} > 0;
        }
        push @result, $c if $occurences{$c};
    }

    return [ @result ];
}

is_deeply(run("bella", "label", "roller"), ['e', 'l', 'l'], "Example 1");
is_deeply(run("cool", "lock", "cook"), ['c', 'o'], "Example 2");
is_deeply(run("hello", "world", "pole"), ['l', 'o'], "Example 3");
is_deeply(run("abc", "def", "ghi"), [], "Example 4");
is_deeply(run("aab", "aac", "aaa"), ['a', 'a'], "Example 5");
is_deeply(run("belal", "label", "aroller"), ['e', 'l', 'a', 'l'], "Example 6");
