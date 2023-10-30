use strict;
use warnings;
use List::Util qw(all);

sub count_consistent_strings {
    my ($allowed, @strings) = @_;
    my $count = 0;
    
    # Create a hash to store allowed characters
    my %allowed_chars = map { $_ => 1 } split //, $allowed;
    
    for my $str (@strings) {
        # Check if all characters in the string are in the allowed characters hash
        if (all { exists $allowed_chars{$_} } split //, $str) {
            $count++;
        }
    }
    
    return $count;
}

# Test the function
use Test::More;

is(count_consistent_strings('ab', 'ad', 'bd', 'aaab', 'baa', 'badab'), 2, 'Test Case 1');
is(count_consistent_strings('abc', 'a', 'b', 'c', 'ab', 'ac', 'bc', 'abc'), 7, 'Test Case 2');
is(count_consistent_strings('cad', 'cc', 'acd', 'b', 'ba', 'bac', 'bad', 'ac', 'd'), 4, 'Test Case 3');

done_testing();

