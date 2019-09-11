# Generate a longest sequence of the following English Pokeman names where 
# each name starts with the last letter of previous name.
#     audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan 
#     deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff
#     kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass 
#     petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid 
#     rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga 
#     trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask

# #Notes/Basically,just me just thinking out loud:
# - I initially used the same approach that I used in my perl5 code:
#     - I tried grep-ing @names to get the candidates instead of preparing them using hash of array, it took approx 1 hr to finish
#     - Then I went back to use hash, it took the exec time to 5 mins!
#     - I used multi threading and exec time went down to 3 mins!
# - 3 mins is still slow compared to perl5 version. 
# - I hope somebody can tell me why perl6 is taking a lot longer vs my perl5 version (< 10 sec)
# - I kept on thinking of a better approcah, then an I came up with an idea...
# - ...this time we are going backwards! Run Time is now under a minute
my Str @names = <bagon audino baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask>;
my Array @chain;
my %hash = ();
my int $max_length = 0;
sub MAIN {
    #We are still using hash but will be looking at the last char instead
    for 'a'..'z' -> $n {
        %hash{$n} = @names.grep(/$n$/);
    }

    #The code below list down the candidates for last names,
    #These are names ending with letter which is NOT 
    #a starting letter of any name in the list @names
    my Str @last_names;
    for @names -> $name {
        my $last = $name.substr(*-1);
        (!grep {/^$last/}, @names) &&  @last_names.push($name);
    }

    #The code below was added to further filter out @last_names
    #and find the best candidate(s) and store it in @best_last
    #The name in @last_name with the most number of linkage 
    #(its first char is same as last char of name in @names) will be used 
    my @best_last;
    for @last_names -> $lname {
        my $first = $lname.substr(0,1);
        my $count = grep { /$first$/}, @names;

        @best_last[$count].push($lname);
    }

    #Use the @best_last as starting point
    for @best_last[*-1] -> @last {
        for @last -> $e {
            my Str $m_name_chain = "";
            iter($e, $m_name_chain, %hash{$e.substr(0,1)}.Seq );
        }
    }

    #Print the longest sequence
    #Print all when they are tied
    say "Sequence:";
    for @chain[*-1] -> @r {
        for @r -> $e {
            say ">"~$e.chop~"\n";
        }
    }
    say "Highest chain count: "~@chain.end;
    say "Number of Sequence found: "~(1+@chain[*-1].end);
    say "Run Time: "~(now - INIT now)~" sec";
}

sub iter {
    my (Str $m_name, Str $m_name_chain, Str @m_name_list) = @_;
    $m_name_chain = " $m_name >" ~ $m_name_chain;
    for @m_name_list -> $name {
        #check and skip if the $name is already in the name sequence in string format 
        #(stored in $m_name_chain)
        if (!$m_name_chain.contains($name)) {
            iter($name, $m_name_chain, %hash{$name.substr(0,1)}.Seq);
        }
    }

    my int $length = +$m_name_chain.comb: ">";
    if ($length >= $max_length) {
        @chain[$length].push($m_name_chain);
        $max_length = $length;
    } 
}
# #Sample output
# Sequence:
# > machamp > petilil > loudred > darmanitan > nosepass > simisear > rufflet > trapinch > heatmor > registeel > landorus > scrafty > yamask > kricketune > emboar > relicanth > haxorus > seaking > girafarig > gabite > exeggcute > emolga > audino
# ..
# > machamp > pinsir > rufflet > trapinch > haxorus > seaking > girafarig > gabite > exeggcute > emboar > relicanth > heatmor > registeel > landorus > simisear > remoraid > darmanitan > nosepass > starly > yamask > kricketune > emolga > alduino
#
# > machamp > pinsir > relicanth > haxorus > seaking > girafarig > gabite > exeggcute > emboar > rufflet > trapinch > heatmor > registeel > landorus > simisear > remoraid > darmanitan > nosepass > starly > yamask > kricketune > emolga > alduino
# 
# Highest chain count: 23
# Number of Sequence found: 1248
# Run Time: 56.786985 sec
# 
# It is still slow compared to my perl5 version, but a big improvement to my previous perl6 solutions