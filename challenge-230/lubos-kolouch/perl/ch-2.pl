use strict;
use warnings;
use Test::More;

sub count_prefix {
    my ( $words, $prefix ) = @_;

    my $count = 0;
    for my $word (@$words) {
        $count++ if $word =~ /^\Q$prefix/;
    }
    return $count;
}

my @words  = ( "pay", "attention", "practice", "attend" );
my $prefix = "at";
is( count_prefix( \@words, $prefix ), 2 );

@words  = ( "janet", "julia", "java", "javascript" );
$prefix = "ja";
is( count_prefix( \@words, $prefix ), 3 );

done_testing();
