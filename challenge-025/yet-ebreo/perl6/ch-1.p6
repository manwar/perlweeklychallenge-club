# Generate a longest sequence of the following English Pokeman names where 
# each name starts with the last letter of previous name.
#     audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan 
#     deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff
#     kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass 
#     petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid 
#     rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga 
#     trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask
my Str @names = <bagon audino baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue vigoroth vulpix wailord wartortle whismur wingull yamask>;
my Array @chain;
my %hash = ();
my int $max_length = 0;
sub MAIN {    
    for '0'..'z' -> $n {
        %hash{$n} = @names.grep(/^$n/);
    }
    
    for @names -> $name {
        my Str $m_name_chain = "";
        iter($name, $m_name_chain, %hash{$name.substr(*-1)}.Seq );
    }
  
    say "Sequence:";
    for @chain[*-1] -> @r {
        for @r -> $e {
            say "$e\n";
        }
    }
    say "Highest chain count: "~@chain.end;
    say "Number of Sequence found: "~(1+@chain[*-1].end);
    say "Run Time: "~(now - INIT now)~" sec";
}

sub iter {
    my (Str $m_name, Str $m_name_chain, Str @m_name_list) = @_;
    $m_name_chain ~= "> $m_name ";
    for @m_name_list -> $name {
        if (!$m_name_chain.contains($name)) {
            iter($name, $m_name_chain, %hash{$name.substr(*-1)}.Seq);
        }
    }
    if (!@m_name_list.end) {
        my int $length = +$m_name_chain.comb: ">";
        if ($length >= $max_length) {
            @chain[$length].push($m_name_chain);
            $max_length = $length;
        }
    }
}

# #Sample output
# Sequence:
# > machamp > petilil > landorus > scrafty > yamask > kricketune > emboar > registeel > loudred > darmanitan > nosepass > simisear > relicanth > heatmor > rufflet > trapinch > haxorus > seaking > girafarig > gabite > exeggcute > emolga > audino
# ..
# > machamp > pinsir > rufflet > trapinch > heatmor > remoraid > darmanitan > nosepass > starly > yamask > kricketune > exeggcute > emboar > registeel > landorus > simisear > relicanth > haxorus > seaking > girafarig > gabite > emolga > audino

# > machamp > pinsir > rufflet > trapinch > heatmor > remoraid > darmanitan > nosepass > starly > yamask > kricketune > exeggcute > emboar > relicanth > haxorus > simisear > registeel > landorus > seaking > girafarig > gabite > emolga > audino
# Highest chain count: 23
# Number of Sequence found: 1248
# Run Time: 319.97691637 sec

# #Note(s):
# - It took 320 seconds to complete!
# - I am a perl6 newbie, I hope somebody can tell me why perl6 is taking a lot longer vs my perl5 version (< 10 sec)
