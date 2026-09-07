#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: Atoms Count
# Given a chemical formula with nested parentheses and multipliers,
# count each atom and return the result sorted alphabetically,
# omitting multiplier 1.

sub count_atoms ($formula) {
    my @stack = ( {} );
    my $len   = length($formula);
    my $i     = 0;

    while ( $i < $len ) {
        my $char = substr( $formula, $i, 1 );

        if ( $char eq '(' ) {
            push @stack, {};
            $i++;
        }
        elsif ( $char eq ')' ) {
            $i++;
            my $start = $i;
            while ( $i < $len && substr( $formula, $i, 1 ) =~ /\d/ ) {
                $i++;
            }
            my $mult_str = substr( $formula, $start, $i - $start );
            my $mult     = length($mult_str) > 0 ? int($mult_str) : 1;

            my $top = pop @stack;
            for my $elem ( keys %$top ) {
                $stack[-1]->{$elem} = ( $stack[-1]->{$elem} // 0 ) + $top->{$elem} * $mult;
            }
        }
        elsif ( $char =~ /[A-Z]/ ) {
            my $start_elem = $i;
            $i++;
            while ( $i < $len && substr( $formula, $i, 1 ) =~ /[a-z]/ ) {
                $i++;
            }
            my $elem = substr( $formula, $start_elem, $i - $start_elem );

            my $start_num = $i;
            while ( $i < $len && substr( $formula, $i, 1 ) =~ /\d/ ) {
                $i++;
            }
            my $mult_str = substr( $formula, $start_num, $i - $start_num );
            my $mult     = length($mult_str) > 0 ? int($mult_str) : 1;

            $stack[-1]->{$elem} = ( $stack[-1]->{$elem} // 0 ) + $mult;
        }
        else {
            die "Unexpected character '$char' at position $i";
        }
    }

    my $counts = $stack[0];
    my $result = '';
    for my $elem ( sort keys %$counts ) {
        $result .= $elem;
        $result .= $counts->{$elem} if $counts->{$elem} > 1;
    }

    return $result;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( count_atoms("((N2O)3(H2O)2)2"),     "H8N12O10",     "Example 1" );
    is( count_atoms("Mg3(PO4)2"),           "Mg3O8P2",      "Example 2" );
    is( count_atoms("(((H)2)3)4"),          "H24",          "Example 3" );
    is( count_atoms("NaCl3(O2(S10)2)2Mg"),  "Cl3MgNaO4S40", "Example 4" );
    is( count_atoms("Z2Y3(X2W)2"),          "W2X4Y3Z2",     "Example 5" );

    done_testing();
}
else {
    say count_atoms( $ARGV[0] );
}
