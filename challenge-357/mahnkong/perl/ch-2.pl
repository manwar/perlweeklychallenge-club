use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($int) {
    my @results;
    my %results;
    for (my $i = 1; $i <= $int; $i++) {
        for (my $j = 1; $j <= $int; $j++) {
            $results{$i / $j} = "$i/$j" unless exists $results{$i / $j};
        }
    }

    foreach my $key (sort(keys(%results))) {
        push @results, $results{$key};
    }

    return [ @results ];
}

is_deeply(run(3), ['1/3','1/2','2/3','1/1','3/2','2/1','3/1'], 'Example 1');
is_deeply(run(4), ['1/4','1/3','1/2','2/3','3/4','1/1','4/3','3/2','2/1','3/1','4/1'], 'Example 2');
is_deeply(run(1), ['1/1'], 'Example 3');
is_deeply(run(6), ['1/6','1/5','1/4','1/3','2/5','1/2','3/5','2/3','3/4','4/5','5/6','1/1','6/5','5/4','4/3','3/2','5/3','2/1','5/2','3/1','4/1','5/1','6/1'], 'Example 4');
is_deeply(run(5), ['1/5','1/4','1/3','2/5','1/2','3/5','2/3','3/4','4/5','1/1','5/4','4/3','3/2','5/3','2/1','5/2','3/1','4/1','5/1'], 'Example 5');
