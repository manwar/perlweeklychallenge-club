use strict;
use warnings;
use experimental 'signatures';
use feature 'say';

sub _longest($N, $i, $acc, $prev) {
    if ($i > @{$N} - 1) {
        my $longest = @{$acc} > @{$prev} ? $acc : $prev;
        return @{$longest} < 2 ? 0 : $longest;
    }

    if ($i == 0 || $N->[$i] == $N->[$i - 1] + 1) {
        push @{$acc}, $N->[$i];
    }
    elsif (@{$acc} > @{$prev}) {
        $prev = $acc;
        $acc = [];
        push @{$acc}, $N->[$i];
    }
    
    return _longest($N, $i + 1, $acc, $prev)
}

sub longest_sequence(@N) {
    my @sorted = sort {$a - $b} @N;
    return _longest \@sorted, 0, [], [];
}

if (@ARGV > 0) {
    use Data::Dumper;
    say Dumper longest_sequence(@ARGV);
    exit 0;
}

use Test::More;

is_deeply longest_sequence(1, 2, 7, 8, 9), [7, 8, 9], 'Tricky test: More elements at the end';
is_deeply longest_sequence(), 0, 'Empty list has no sequences';
is_deeply longest_sequence(4), 0, 'One element has no sequence';
is_deeply longest_sequence(4, 3), [3, 4], 'Two elements';
is_deeply longest_sequence(4, 3, 2, 1), [1, 2, 3, 4], 'All elements reversed';
is_deeply longest_sequence(4, 7, 2, 1), [1, 2], 'Two elements out of four';
is_deeply longest_sequence(4, 7, 2, 1, 5, 99, 6), [4, 5, 6, 7], 'Four elements';
is_deeply longest_sequence(100, 4, 50, 3, 2), [2, 3, 4], 'Test 1 from PWC';
is_deeply longest_sequence(20, 30, 10, 40, 50), 0, 'Test 2 from PWC';
is_deeply longest_sequence(20, 19, 9, 11, 10), [9, 10, 11], 'Test 3 from PWC';

done_testing;
