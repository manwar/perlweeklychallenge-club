use strict;
use warnings;
use Math::Fraction;

sub find_ancestors {
    my ($fraction) = @_;
    my ( $num, $denom ) = split( '/', $fraction );
    my $parent =
      $denom > $num
      ? Math::Fraction->new( $num,          $denom - $num )
      : Math::Fraction->new( $num - $denom, $denom );
    my $grandparent =
      $parent->denominator > $parent->numerator
      ? Math::Fraction->new( $parent->numerator,
        $parent->denominator - $parent->numerator )
      : Math::Fraction->new( $parent->numerator - $parent->denominator,
        $parent->denominator );
    return $parent->to_string, $grandparent->to_string;
}

print join( ' and ', find_ancestors('3/5') ), "\n";    # Output: 3/2 and 1/2
print join( ' and ', find_ancestors('4/3') ), "\n";    # Output: 1/3 and 1/2
