#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub get_person ( $family_members, $exclude ) {
    # Sort the family dict by frequency, largest first
    my @sorted_surname = sort {
        scalar( @{ $family_members->{$b} } ) <=>
          scalar( @{ $family_members->{$a} } )
    } keys %$family_members;

    # If we want to exclude a surname, chose the second option if the exclude
    #  name is first, and there is a second option
    if (    $exclude
        and $sorted_surname[0] eq $exclude
        and $#sorted_surname > 0
        and scalar( @{ $family_members->{ $sorted_surname[1] } } ) > 0 )
    {
        return $sorted_surname[1];
    }

    return $sorted_surname[0];
}

sub get_surname ($name) {
    my $i = rindex( $name, ' ' );
    if ( $i != -1 ) {
        return substr( $name, $i + 1 );
    }

    # A person with nothing before their surname
    return $name;
}

sub main (@people) {
    my @chain = ();

    # Calculate the frequency of each family
    my %family_members = ();
    foreach my $p (@people) {
        my $surname = get_surname($p);
        push @{ $family_members{$surname} }, $p;
    }

    # Get the first person, and seed the chain
    my $current_surname = get_person( \%family_members, undef );
    my $first_person    = pop( @{ $family_members{$current_surname} } );
    push @chain, $first_person;

    foreach ( 1 .. $#people ) {
        my $next_surname = get_person( \%family_members, $current_surname );
        push @chain, shift( @{ $family_members{$next_surname} } );

        # Repeat for the next person
        $current_surname = $next_surname;
    }

    # The last person gives to the first person
    push @chain, $chain[0];

    # Print the results
    foreach my $i ( 0 .. $#people ) {
        say "$chain[$i] -> $chain[$i+1]";
    }
}

main(@ARGV);