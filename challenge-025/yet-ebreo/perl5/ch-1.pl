# Generate a longest sequence of the following English Pokeman names where 
# each name starts with the last letter of previous name.
#     audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan 
#     deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff
#     kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass 
#     petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid 
#     rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga 
#     trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask

use strict;
use warnings;
use 5.010;

my $start_run = time();

my @names = qw(bagon audino baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask);
my %hash;
my $max_length = 0;
my @chain;

#First, I need to group each name (in @names) by the starting letter
#so that I dont have to filter out @names in each iteration
#For this, I used Hashes of Arrays which will be structured like so:
#%hash = (
#    a => ["aduino"],
#    ...
#    e => ["emboar", "emolga", "exeggcute"],
#    ..
#    y => ["yamask"],
#)
for my $n (@names) {
    my $first = substr $n,0,1;
    push @{$hash{$first}}, $n;
}

#Iterate in each name in @names as start of sequence
for my $name (@names) {   
    my $last_char = substr $name,-1;
    #The first argumet is the starting name
    #The second argument is the name sequence in string format which would start as blank string. 
    # - I know there is probably a better approach but this is where I ended up with 
    #Last argument is an array from our Hashes of Array (%hash), this is to limit the iterations 
    #to names starting with the last letter of the first argument ($name) only instead of
    #going through @names and checking if it starts with <X> letter
    &iter($name, "", @{$hash{$last_char}} );
}

sub iter {
    my ($m_name, $m_name_arr , @m_name_list ) = @_;
    $m_name_arr .= "> $m_name ";

    for my $name (@m_name_list) {
        #check and skip if the $name is already in the name sequence in string format (stored in $m_name_arr, not really an 'ARR'ay lols)
        if (index($m_name_arr, $name) <0) {
            my $last_char = substr $name,-1;
            &iter($name, $m_name_arr, @{$hash{$last_char}} );
        } 
    }

    #Only do computation when name list is empty
    if (!@m_name_list) {
        #from what I understand the task was asking for the longest sequence,
        #I assumed that it referes to the highes number of names/chain in a valid sequence (not character count)
        my $length = $m_name_arr=~y/>//; 
        if ($length >= $max_length) {
            push @{$chain[$length]}, $m_name_arr;
            $max_length = $length;
        }
    }
    
}

#Print the longest sequence
#Print all when they are tied
say "Sequence:";
for my $seq (@{$chain[-1]}) {
    say "$seq\n";
}
say "Highest chain count: $#chain";
say "Number of Sequence found: ".@{$chain[-1]};

my $run_time = time() - $start_run;
say "Run Time: $run_time sec";

=begin
#Sample output
Sequence:
> machamp > petilil > landorus > scrafty > yamask > kricketune > emboar > registeel > loudred > darmanitan > nosepass > simisear > relicanth > heatmor > rufflet > trapinch > haxorus > seaking > girafarig > gabite > exeggcute > emolga > audino
..
> machamp > pinsir > rufflet > trapinch > heatmor > remoraid > darmanitan > nosepass > starly > yamask > kricketune > exeggcute > emboar > registeel > landorus > simisear > relicanth > haxorus > seaking > girafarig > gabite > emolga > audino

> machamp > pinsir > rufflet > trapinch > heatmor > remoraid > darmanitan > nosepass > starly > yamask > kricketune > exeggcute > emboar > relicanth > haxorus > simisear > registeel > landorus > seaking > girafarig > gabite > emolga > audino
Highest chain count: 23
Number of Sequence found: 1248
Run Time: 5 sec

#Note(s):
- There are actually 1248 sequences with 23 chain counts. I decided to print them all. 
- I am surprised with the speed compared to other algorithms.
- I appreciate the challenges for this week, they are actually challenging. Thanks!
=cut
