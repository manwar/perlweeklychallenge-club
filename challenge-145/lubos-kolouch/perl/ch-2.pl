use strict;
use warnings;

sub palindromic_tree {
    my ($s) = @_;
    my @result;
    for my $i ( 0 .. length($s) - 1 ) {
        for my $j ( $i + 1 .. length($s) ) {
            my $substring = substr $s, $i, $j - $i;
            if ( $substring eq reverse $substring ) {
                push @result, $substring;
            }
        }
    }
    return \@result;
}

my $s = 'redivider';
print join( " ", @{ palindromic_tree($s) } ),
  "\n";    # Output: r redivider e edivide d divid i ivi v

$s = 'deific';
print join( " ", @{ palindromic_tree($s) } ), "\n";    # Output: d e i ifi f c
