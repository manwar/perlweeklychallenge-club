#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';

=pod

=head1 PURPOSE

Implementation for The Weekly Challenge 340, Task 2: decide whether the numeric
values embedded in a space-separated token stream form a strictly increasing
sequence.

=head1 ALGORITHM

We split the input on single spaces and process each token. Tokens matching the
pattern for non-negative integers without leading zeros are interpreted as
numbers. Each number is compared with the previously seen numeric value; the
sequence fails if we ever see a decrease or plateau. If no violation occurs, the
sequence is strictly increasing.

=cut

sub ascending_numbers ($str) {
    _assert_plain_string($str);

    my $last;
    for my $token ( split / /, $str ) {
        next unless _is_valid_integer_token($token);

        my $value = 0 + $token;
        return 0 if defined $last && $value <= $last;
        $last = $value;
    }

    return 1;
}

sub _is_valid_integer_token ($token) {
    return $token eq '0' || $token =~ /\A[1-9]\d*\z/;
}

sub _assert_plain_string ($value) {
    die 'Input must be a defined, non-reference string'
      if !defined $value || ref $value;
}

sub _bool_to_text ($bool) {
    return $bool ? 'true' : 'false';
}

unless (caller) {
    require Test::More;
    Test::More->import( tests => 5 );

    Test::More::is( _bool_to_text( ascending_numbers('The cat has 3 kittens 7 toys 10 beds') ),
        'true', 'Example 1' );
    Test::More::is( _bool_to_text( ascending_numbers('Alice bought 5 apples 2 oranges 9 bananas') ),
        'false', 'Example 2' );
    Test::More::is( _bool_to_text( ascending_numbers('I ran 1 mile 2 days 3 weeks 4 months') ),
        'true', 'Example 3' );
    Test::More::is( _bool_to_text( ascending_numbers('Bob has 10 cars 10 bikes') ),    'false', 'Example 4' );
    Test::More::is( _bool_to_text( ascending_numbers('Zero is 0 one is 1 two is 2') ), 'true',  'Example 5' );
}
