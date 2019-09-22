#!perl

################################################################################
=comment

Perl Weekly Challenge 025
=========================

Task #1
-------
Generate a longest sequence of the following *English Pokeman* names where each
name starts with the last letter of previous name.

  audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon
  cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig
  gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan
  kricketune landorus ledyba loudred lumineon lunatone machamp magnezone
  mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
  porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede
  scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga
  trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull
  yamask

The above names borrowed from
[ https://en.wikipedia.org/wiki/List_of_Pok%C3%A9mon |wiki page].

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use utf8;
use Const::Fast;
use List::MoreUtils qw( uniq );
use constant DEBUG => 1;

const my @NAMES =>
qw(
    audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon
    cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig
    gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan
    kricketune landorus ledyba loudred lumineon lunatone machamp magnezone
    mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
    porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede
    scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga
    trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull
    yamask
  );

const my $NUM_NAMES => scalar @NAMES;

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    print("There are $NUM_NAMES different Pokémon names\n") if DEBUG;

    my   %pairs;
    push $pairs{ substr($_, 0, 1) . substr($_, -1) }->@*, $_ for @NAMES;
    my   @chains   = sort keys %pairs;
    my   %dominoes = map { $_ => scalar( $pairs{$_}->@* ) } @chains;

    printf("%2d: %6d\n", 1, scalar @chains) if DEBUG;

    for my $i (2 .. $NUM_NAMES)
    {
        my @new_chains;

        for my $chain (@chains)
        {
            my $last = substr $chain, -1;
            my %local_dominoes = %dominoes;
             --$local_dominoes{ $1 } while $chain =~ /(..)/g;

            for my $domino (sort keys %local_dominoes)
            {
                push @new_chains, $chain . $domino
                    if $local_dominoes{$domino} > 0 &&
                       $last eq substr($domino, 0, 1);
            }
        }

        last if scalar @new_chains == 0;

        @chains = uniq @new_chains;

        printf("%2d: %6d\n", $i, scalar @chains) if DEBUG;
    }

    my $solution = $chains[0];

    printf "The longest sequences of the %d given Pokémon names contain %d " .
           "elements; e.g.:\n\n%s\n", $NUM_NAMES, length($solution) / 2,
            join ', ', decode_chain($solution, \%pairs);
}

#-------------------------------------------------------------------------------
sub decode_chain
#-------------------------------------------------------------------------------
{
    my ($chain, $pairs) = @_;
    my  @sequence;

    while ($chain =~ /(..)/g)
    {
        my $pair  = $1;
        my @names = $pairs->{$pair}->@*;
        my $name  = shift @names;

        push @sequence, $name;

        $pairs->{$pair} = \@names;
    }

    return @sequence;
}

################################################################################

__END__

 2:27 >perl ch-1.pl

There are 70 different Pokémon names
 1:     64
 2:    153
 3:    414
 4:   1025
 5:   2433
 6:   5529
 7:  11964
 8:  24270
 9:  46046
10:  81197
11: 131728
12: 194642
13: 260203
14: 311684
15: 331912
16: 310198
17: 249704
18: 169904
19:  96066
20:  43676
21:  15128
22:   3648
23:    416
The longest sequences of the 70 given Pokémon names contain 23 elements; e.g.:

machamp, petilil, loudred, darmanitan, nosepass, seaking, girafarig, gabite, exe
ggcute, emboar, relicanth, heatmor, registeel, landorus, simisear, rufflet, trap
inch, haxorus, scrafty, yamask, kricketune, emolga, audino

 2:30 >
