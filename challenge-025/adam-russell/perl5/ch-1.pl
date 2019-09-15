use strict;
use warnings;
##
# Generate a longest sequence of "English Pokemon" names.
##
use Graph;

sub build_pokegraph{ 
    my @pokemon;
    my %first_letter_name; 
    my $graph = new Graph(); 
    while(my $pokemon = <DATA>){
        $pokemon = lc($pokemon);
        chomp($pokemon);
        my $first_letter = substr($pokemon, 0, 1);      
        if($first_letter_name{$first_letter}){
            push @{$first_letter_name{$first_letter}}, $pokemon; 
        }
        else{
            $first_letter_name{$first_letter} = [$pokemon]; 
        }  
        push @pokemon, $pokemon;   
    }
    for my $pokemon (@pokemon){
        $graph->add_vertex($pokemon) if !$graph->has_vertex($pokemon);
        my $child_nodes = $first_letter_name{substr($pokemon, -1)};
        for my $n (@{$child_nodes}){
            $graph->add_vertex($n) if !$graph->has_vertex($n);
            $graph->add_weighted_edge($pokemon, $n, (-1 * length($n))) if !$graph->has_edge($pokemon, $n);   
            $graph->delete_edge($pokemon, $n) if $graph->has_a_cycle(); 
        }  
    }   
    return (\@pokemon, $graph);
}

MAIN:{
    my ($pokemon, $graph) = build_pokegraph(); 
    my $apsp = $graph->APSP_Floyd_Warshall();
    my $max_path;  
    my $max_path_length = -1;  
    for my $p0 (@{$pokemon}){
        for my $p1 (@{$pokemon}){
            my @vertices = $apsp->path_vertices($p0, $p1);
            my $l = join("", @vertices);
            if(length($l) > $max_path_length){  
                $max_path_length = length($l); 
                $max_path = join("-", @vertices); 
            } 
        }  
    }
    print "$max_path $max_path_length\n"; 
}

__DATA__
audino
bagon
baltoy
banette
bidoof
braviary
bronzor
carracosta
charmeleon
cresselia
croagunk
darmanitan
deino
emboar
emolga
exeggcute
gabite
girafarig
gulpin
haxorus
heatmor
heatran
ivysaur
jellicent
jumpluff
kangaskhan
kricketune
landorus
ledyba
loudred
lumineon
lunatone
machamp
magnezone
mamoswine
nosepass
petilil
pidgeotto
pikachu
pinsir
poliwrath
poochyena
porygon2
porygonz
registeel
relicanth
remoraid
rufflet
sableye
scolipede
scrafty
seaking
sealeo
silcoon
simisear
snivy
snorlax
spoink
starly
tirtouga
trapinch
treecko
tyrogue
vigoroth
vulpix
wailord
wartortle
whismur
wingull
yamask
