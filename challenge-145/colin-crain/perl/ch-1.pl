#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       zip-ties-and-dotted-eyes.pl
#
#       Dot Product
#         Submitted by: Mohammad S Anwar
#         You are given 2 arrays of same size, @a and @b.
# 
#         Write a script to implement Dot Product.
# 
#         Example:
#             @a = (1, 2, 3);
#             @b = (4, 5, 6);
# 
#         $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub dot ( $array1, $array2 ) {
    return undef unless $array1->@* == $array2->@*;
    my $out = 0;
    while ( my ($k,$v) = each $array1->@*) {
        $out += $v * $array2->[$k];
    }
    return $out;
}

sub dot_u ( $a1, $a2 ) {
    use List::Util qw( zip sum );
    return  sum 
            map { $_->[0] * $_->[1] } 
            zip( $a1, $a2 )

}


my $a1 = [ 1, 2, 3 ];
my $a2 = [ 2, 4, 6 ];

say dot( $a1, $a2);
say dot_u( $a1, $a2);









# use Test::More;
# 
# is 
# 
# done_testing();
