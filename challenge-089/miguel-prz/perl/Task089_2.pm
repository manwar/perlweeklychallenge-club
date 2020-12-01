package Task089_2;

use strict;
use warnings;


=head1 NAME

Task089_2 - TASK 089 #2: Magical Matrix

=head1 SYNOPSIS

Display matrix as below with numbers 1 - 9. Make sure numbers are used once.

   [ a b c ]
   [ d e f ]
   [ g h i ]

   a + b + c = 15
   d + e + f = 15
   g + h + i = 15
   a + d + g = 15
   b + e + h = 15
   c + f + i = 15
   a + e + i = 15
   c + e + g = 15

=cut


# Test the magic rules. A hash ref with a-i keys is required. Returns:
#   0: a rule failed
#   1: all rules are ok

sub _check_magic_rules_ {
    my $matrix = shift;

    return 0 if $matrix->{a} + $matrix->{b} + $matrix->{c} != 15;
    return 0 if $matrix->{d} + $matrix->{e} + $matrix->{f} != 15;
    return 0 if $matrix->{g} + $matrix->{h} + $matrix->{i} != 15;

    return 0 if $matrix->{a} + $matrix->{d} + $matrix->{g} != 15;
    return 0 if $matrix->{b} + $matrix->{e} + $matrix->{h} != 15;
    return 0 if $matrix->{c} + $matrix->{f} + $matrix->{i} != 15;

    return 0 if $matrix->{a} + $matrix->{e} + $matrix->{i} != 15;
    return 0 if $matrix->{c} + $matrix->{e} + $matrix->{g} != 15;

    return 1;
}


# Check if two array refs have at least one equal element (1) or not (0)

sub _match_arrays_ {
    my $arr_1 = shift;
    my $arr_2 = shift;

    for my $i( $arr_1->@* ) {
        for my $j( $arr_2->@* ) {
            return 1 if $i == $j;
        }
    }
    return 0;
}

sub _set_magic_matrix_values_ {
    my $mag_mat = shift;
    my $keys = shift;
    my $values = shift;
    for (my $i=0; $i<@$keys; $i++) {
        $mag_mat->{$keys->[$i]} = $values->[$i];
    }
}

=head2 check_magic_rules

Check if two array refs have at least one equal element (1) or not (0)

=cut

sub magical_matrix {
    
    my @solutions = ();
    my $mag_mat = {}; 
    


    # 1. fill @valid with 3-tuples that sum 15
    my $valid = [];
    my @digits = (1..9);
    for my $i (@digits) {
        for my $j (grep { !/$i/ } @digits ) {
            for my $k (grep { !/$i|$j/ } @digits )  {
                push $valid->@*, [$i, $j, $k] if $i+$j+$k == 15;
            }
        }
    }

    # Try valid 3-tuples for row 1
    for my $current_1 ($valid->@*) {
        _set_magic_matrix_values_ ( $mag_mat, [qw/a b c/], $current_1 );

        # Filter the tuples candidates for 2nd row
        my @valid_2 = grep { ! _match_arrays_ ($_, $current_1) } $valid->@*;
        
        # Try valid 3-tuples for row 2
        for my $current_2 (@valid_2) {
            _set_magic_matrix_values_ ( $mag_mat, [qw/d e f/], $current_2 );

            # Filter the tuples candidates for 3nd row
            my @valid_3 = grep { ! _match_arrays_ ($_, $current_2) } @valid_2;
            
            # Try valid 3-tuples for row 3
            for my $current_3 (  @valid_3 ) {
                _set_magic_matrix_values_( $mag_mat, [qw/g h i/], $current_3 );

                # Check the magic rules, and if ok, add the current setup to
                # the final solutions
                _check_magic_rules_ ($mag_mat) 
                    && push @solutions, [$current_1, $current_2, $current_3]; 
            }
        }
    }

    return @solutions;  
}

#----


1970;