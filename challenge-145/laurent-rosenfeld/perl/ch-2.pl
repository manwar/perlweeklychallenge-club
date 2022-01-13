use strict;
use warnings;
use feature "say";

sub is_palindrome { return $_[0] eq reverse $_[0]; }

sub find_all_palindromes {
    my $input = shift;
    print "$input: ";
    my %seen;
    my $str_length = length $input;
    for my $start (0..$str_length) {
        for my $length (1.. $str_length - $start) {
            my $candidate = substr $input, $start, $length;
            next unless is_palindrome $candidate;
            next if $seen{$candidate};
            $seen{$candidate} = 1;
            print "$candidate ";
        }
    }
    say " ";
}

for my $test (qw <redivider deific rotors
              challenge champion christmas>) {
        find_all_palindromes $test;
}
