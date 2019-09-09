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

my @names = qw(bagon audino  baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask);

my %hash;
my $longest_string;
my $max_length = 0;
my $length = 0;

#First I need to group each name (in @names) by the starting letter
#so that I dont have to filter out @names in each iteration
#For this, I used Hashes of Arrays which will be structured like so:
#%hash = (
#    a => ["aduino"],
#    ...
#    e => ["emboar", "emolga", "exeggcute"],
#    ..
#    z => ["yamask"],
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
    #Last argument is an array from our Hashes of Array (%hash), this to limit the iterations 
    #to names starting with the last letter of the first argument ($name) only instead of
    #going through @names and checking if it starts with X letter
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
        #I assumed that it referes to the highes number of names in a valid sequence (not character count)
        my $length = $m_name_arr=~y/>//; 
        if ($length > $max_length) {
            $longest_string = $m_name_arr;
            $max_length = $length;
        }
    }
    
}

#Print the longes sequence
say "longest Sequence is: $longest_string";
say "Number of Names: $max_length";

my $run_time = time() - $start_run;
say "Run Time: $run_time sec";

=begin
longest Sequence is: > machamp > petilil > landorus > scrafty > yamask > kricketune > emboar > registeel > loudred > darmanitan > nosepass > simisear > relicanth > heatmor > rufflet > trapinch > haxorus > seaking > girafarig > gabite > exeggcute > emolga > audino
Number of Names: 23
Run Time: 5 sec

#Note:
The sequence below also has 23 names but the first occurence of the highest # of names will be the only one reflected. 
Also the result above is the longest in terms of number of characters.

longest Sequence is: > machamp > pinsir > rufflet > trapinch > heatmor > remoraid > darmanitan > nosepass > starly > yamask > kricketune > exeggcute > emboar > relicanth > haxorus > simisear > registeel > landorus > seaking > girafarig > gabite > emolga > audino
Number of Names: 23
Run Time: 5 sec
=cut
