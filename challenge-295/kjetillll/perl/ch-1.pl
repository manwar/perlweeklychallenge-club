#https://theweeklychallenge.org/blog/perl-weekly-challenge-295/
#input: a string and an array of strings
#output: true|false wether the string can be built from zero, one or more occurences of the strings in the array

use strict; use warnings; use Test::More tests => 5;

sub can_be_segmented_by {
    my( $string, @words ) = @_;
    $string =~ /^ ( @{[ join '|', @words ]} )+ $/x
}


my($true, $false) = (1, '');
for my $test (
    [ 'weeklychallenge'  => 'challenge', 'weekly'                    => $true ],
    [ 'perlrakuperl'     => 'raku', 'perl'                           => $true ],
    [ 'sonsanddaughters' => 'sons', 'sand', 'daughters'              => $false ],
    [ 'asonsanddaughters' => 'sons', 'sand', 'daughters', 'and'      => $false ],
    [ 'asonsanddaughters' => 'sons', 'sand', 'daughters', 'and', 'a' => $true ],
){
    my $expected = pop @$test;
    is can_be_segmented_by( @$test ) => $expected;
}
