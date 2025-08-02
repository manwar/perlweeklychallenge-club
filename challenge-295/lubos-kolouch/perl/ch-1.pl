#!/usr/bin/perl
use strict;
use warnings;

sub word_break {
    my ( $str, @words ) = @_;

    # Create a set of words for quick lookup
    my %word_set = map { $_ => 1 } @words;

    my $length = length($str);
    my @dp     = (0) x ( $length + 1 );
    $dp[0] = 1;    # Empty string can be segmented

    for my $i ( 1 .. $length ) {
        for my $j ( 0 .. $i - 1 ) {
            if ( $dp[$j] && exists $word_set{ substr( $str, $j, $i - $j ) } ) {
                $dp[$i] = 1;
                last;
            }
        }
    }

    return $dp[$length] ? 'true' : 'false';
}

# Test cases
my @test_cases = (
    { str => 'weeklychallenge',  words => [ 'challenge', 'weekly' ],               expected => 'true' },
    { str => 'perlrakuperl',     words => [ 'raku', 'perl' ],                      expected => 'true' },
    { str => 'sonsanddaughters', words => [ 'sons', 'sand', 'daughters' ],         expected => 'false' },
    { str => 'applepenapple',    words => [ 'apple', 'pen' ],                      expected => 'true' },
    { str => 'catsandog',        words => [ 'cats', 'dog', 'sand', 'and', 'cat' ], expected => 'false' },
);

foreach my $test (@test_cases) {
    my $result = word_break( $test->{str}, @{ $test->{words} } );
    print "Input: \$str = \"$test->{str}\", \@words = (" . join( ', ', @{ $test->{words} } ) . ")\n";
    print "Output: $result\n";
    print "Expected: $test->{expected}\n";
    print "-" x 40 . "\n";
}
