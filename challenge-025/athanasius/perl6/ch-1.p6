use v6;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my Bool constant $DEBUG = True;

my constant @NAMES =
<
    audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon
    cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig
    gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan
    kricketune landorus ledyba loudred lumineon lunatone machamp magnezone
    mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
    porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede
    scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga
    trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull
    yamask
>;

my UInt constant $NUM-NAMES = @NAMES.elems;

BEGIN say '';

#===============================================================================
sub MAIN()
#===============================================================================
{
    "There are $NUM-NAMES different Pokemon names".say if $DEBUG;

    my %pairs;
       %pairs{ .substr(0, 1) ~ .substr(*-1) }.push($_) for @NAMES;
    my @chains   = %pairs.keys.sort;
    my %dominoes = @chains.map: { $_ => %pairs{$_}.elems };

    "%2d: %6d\n".printf(1, @chains.elems) if $DEBUG;

    for 2 .. $NUM-NAMES -> UInt $i
    {
        my @new-chains;

        for @chains -> Str $chain
        {
            my Str $last      = $chain.substr(*-1);
            my     %available = %dominoes;
            my     @matches   = m:g/(..)/ given $chain;

            --%available{ $_ } for @matches;

            for %available.keys.sort -> Str $domino
            {
                if %available{$domino} > 0
                {
                    my Str $first = $domino.substr(0, 1);
                    @new-chains.push: $chain ~ $domino if $last eq $first;
                }
            }
        }

        last if @new-chains.elems == 0;

        @chains = @new-chains.unique;

        "%2d: %6d\n".printf($i, @chains.elems) if $DEBUG;
    }

    my Str $solution = @chains[0];

    ("The longest sequences of the %d given Pokemon names contain %d " ~
       "elements; e.g.:\n\n%s\n").printf: $NUM-NAMES, $solution.chars / 2,
        decode-chain($solution, %pairs).join(', ');
}

#-------------------------------------------------------------------------------
sub decode-chain(Str:D $chain, %pairs)
#-------------------------------------------------------------------------------
{
    my @sequence;
    my @matches = m:g/(..)/ given $chain;

    for @matches.map: { .Str } -> Str $pair
    {
        my @names = @( %pairs{$pair} );
        my $name  = @names.shift;

        @sequence.push: $name;

        %pairs{$pair} = @names;
    }

    return @sequence;
}

################################################################################
