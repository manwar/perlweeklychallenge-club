#! /opt/local/bin/perl
#
#       pokemon.pl
#
#       task: Generate a longest sequence of the following “English Pokemon” names
#           where each name starts with the last letter of previous name.
#
#       method: there are 70! combinations of the 70 pokemon named, or about
#           1.197857e+100. By noting first and last letters of each name, and
#           creating a lookup index of first letters pointing to a list of pokemon
#           whose names start with that letter we can reduce the search space. The
#           number of valid permutations is then a little over 5,000,000. Using a
#           recursive descent down the search tree we examine only these valid linkages,
#           keeping a running tally of the longest list found. After determining the
#           length of the longest list and the first such occurence at that length, I
#           wondered how many such lists of that length existed, so created a global
#           "list of lists" and preserved them as they came up.
#
#       results: examining the lists of longest possible chains reveals groupings of
#           pokemon names that begin and end with the same letters that can be interchanged
#           to create new combinations without changing the overall list length. For example:
#               seaking, girafarig, gabite, emboar
#           can be swapped with the single entity
#               simisear
#           in any list containing both groupings without changing the list length.
#           As such there are 1248 different lists of maximum length 23 pokemon.
#           As a further aside I decided to combine these creatures into one monstrous
#           mega-monster by concatenating one such list of 23 creatures into one name.
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## CONFIG

my @pokemon = qw(audino bagon baltoy banette bidoof braviary bronzor carracosta
charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite
girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan
kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine
nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz
registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo
silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue
vigoroth vulpix wailord wartortle whismur wingull yamask);

## ## ## ## ## MAIN

## create the pokehash data structure
#       example:    $pokehash->{tyrogue} => { 'first' => 't',
#                                            'last'  => 'e'  }
my $pokehash = { map { $_, { "first" => (substr $_, 0, 1), "last" => (substr $_, -1) } } @pokemon };

my $index = {};
for my $monster ( @pokemon ) {
            if (exists $index->{ $pokehash->{$monster}->{first} }) {
                push  $index->{ $pokehash->{$monster}->{first} }->@*, $monster;
            }
            else {
                $index->{ $pokehash->{$monster}->{first} } = [$monster];
            }
        }

my $list = [];
my $longest = [];
my $list_of_longest_lists = [];     ## global

## iterate through the pokemon, doing a depth-first descent of permutations through the graph
## of each pokemon linked to each pokemon whose name starts with the last letter of the previous.
for (@pokemon) {
    $list = [$_];
    $longest = get_next_node( $pokehash, $index, $list, $longest);
}

## report the findings
say "from a group of ", scalar @pokemon, " pokemon:";
say "longest list length: ", scalar $longest->@*, " pokemon";
say "first list found at this length: \n", (join ', ', $longest->@*);
say "number of lists at this length: ", scalar $list_of_longest_lists->@*;
my $i;
for my $list ( $list_of_longest_lists->@* ){
    print ++$i, ":\t";
    say (join ', ', $list->@*);
}

## create a monstrous concatenation of the names of the first list into one long word
my $lastlink =  $longest->[-1];
my $monstrosity;
for my $monster ( $longest->@* ) {
    chop $monster;
    $monstrosity .= $monster;
}
$monstrosity .= $lastlink;
say "one name for a giant monstrosity of a creature composed of an amagamation of all ",
        scalar $longest->@*, " pokemon is: \n", $monstrosity;


## ## ## ## ## SUBS

sub get_next_node {
    my ( $pokehash, $index, $list, $longest) = @_;

    ## copy the current list
    my @newlist = $list->@*;

    ## if the current list exceeds the length of the longest list, replace it with this one
    if (scalar @newlist > scalar $longest->@*) {
        $longest = \@newlist;
        $list_of_longest_lists = [\@newlist];       ## reset the list of lists for this new length
    }
    elsif ( scalar @newlist == scalar $longest->@* ) {
        push $list_of_longest_lists->@*, \@newlist;
    }

    my $current_pokemon = $newlist[-1];
    my $last_letter = $pokehash->{$current_pokemon}->{last};

    ## if there is no index lookup there are no more possible links so return
    return $longest if not exists $index->{$last_letter};

    ## create a lookup hash for the pokemon that are in the current list
    my %inlist = map { $_ => 1 } @newlist;

    ## get each possible following pokemon from the index
    for my $pokemon ( $index->{$last_letter}->@* ){

        ## skip if this pokemon has already been chained
        next if exists $inlist{$pokemon};

        ## extend the chain and recurse
        my $nextlist = [@newlist, $pokemon];
        $longest = get_next_node( $pokehash, $index, $nextlist, $longest);
    }

    return $longest;
}
