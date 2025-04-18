use strict;
use warnings;
use Test::More;

sub is_acronym {
    my ( $words, $target ) = @_;

    # Input validation
    return 0 if !$words || !@$words || !$target;

    # Join first letters and compare
    my $acronym = join '', map { substr( $_, 0, 1 ) } @$words;
    return $acronym eq $target ? 1 : 0;
}

# Unit Tests
subtest 'Acronym Tests' => sub {
    is( is_acronym( [ "Perl", "Weekly", "Challenge" ], "PWC" ), 1, 'Example 1' );
    is( is_acronym( [ "Bob", "Charlie", "Joe" ],       "BCJ" ), 1, 'Example 2' );
    is( is_acronym( [ "Morning", "Good" ],             "MM" ),  0, 'Example 3' );
    is( is_acronym( [],                                "PWC" ), 0, 'Empty array' );
    is( is_acronym( ["Perl"],                          "" ),    0, 'Empty target' );
    is( is_acronym( [ "A", "B", "C" ],                 "ABC" ), 1, 'Single letter words' );
    is( is_acronym( [ "perl", "weekly" ],              "PWC" ), 0, 'Case sensitivity' );
    is( is_acronym( [ "", "Weekly" ],                  "PWC" ), 0, 'Empty word' );
};

done_testing();
