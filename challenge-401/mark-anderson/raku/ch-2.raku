#!/usr/bin/env raku
use JSON::Fast;
use Test;
 
sub reconstruct-digits($str)
{
    my $bag = $str.comb.BagHash;
    my $res = BagHash.new;

    my %n = <zero one two three four five six seven eight nine>.antipairs;

    for 'z' => <z e r o>,   'w' => <t w o>, 
        'u' => <f o u r>,   'x' => <s i x>, 
        'g' => <e i g h t>, 'o' => <o n e>,
        't' => <t h r e e>, 'f' => <f i v e>,
        's' => <s e v e n>, 'i' => <n i n e>
    {
        my $v = $bag{.key}; 
        $res{%n{.value.join}} += $v;
        $bag{.value} >>-=>> $v
    }

    $res.kxxv.sort.join
}

sub reconstruct-digits-v2($str)
{
    # 
    # This isn't an efficient solution but the final
    # test only takes about 0.4 second on my computer.  
    #

    grammar G
    {
        my $zero  = <z e r o>\   .permutations>>.join.join('|');
        my $one   = <o n e>\     .permutations>>.join.join('|');
        my $two   = <t w o>\     .permutations>>.join.join('|');
        my $three = <t h r e e>\ .permutations.unique(with => &[eqv])>>.join.join('|');
        my $four  = <f o u r>\   .permutations>>.join.join('|');
        my $five  = <f i v e>\   .permutations>>.join.join('|');
        my $six   = <s i x>\     .permutations>>.join.join('|');
        my $seven = <s e v e n>\ .permutations.unique(with => &[eqv])>>.join.join('|');
        my $eight = <e i g h t>\ .permutations>>.join.join('|');
        my $nine  = <n i n e>\   .permutations.unique(with => &[eqv])>>.join.join('|');

        token TOP { <cardinal>+ } # 342 alternations 😳 
    
        proto token cardinal            {*} 
              token cardinal:sym<zero>  { <$zero>  }
              token cardinal:sym<one>   { <$one>   }
              token cardinal:sym<two>   { <$two>   }
              token cardinal:sym<three> { <$three> }
              token cardinal:sym<four>  { <$four>  }
              token cardinal:sym<five>  { <$five>  }
              token cardinal:sym<six>   { <$six>   }
              token cardinal:sym<seven> { <$seven> }
              token cardinal:sym<eight> { <$eight> }
              token cardinal:sym<nine>  { <$nine>  }
    } 
    
    class Actions
    {
        method TOP($/)                 { make $<cardinal>>>.made.sort.join }
        method cardinal:sym<zero>($/)  { make 0 }
        method cardinal:sym<one>($/)   { make 1 }
        method cardinal:sym<two>($/)   { make 2 }
        method cardinal:sym<three>($/) { make 3 }
        method cardinal:sym<four>($/)  { make 4 }
        method cardinal:sym<five>($/)  { make 5 }
        method cardinal:sym<six>($/)   { make 6 }
        method cardinal:sym<seven>($/) { make 7 }
        method cardinal:sym<eight>($/) { make 8 }
        method cardinal:sym<nine>($/)  { make 9 }
    }
    
    G.parse($str, actions => Actions).made
}

my %json = from-json "../../examples/json/ch-2.json".IO.slurp;

for &reconstruct-digits, &reconstruct-digits-v2
{
    for %json<examples>.flat -> $example
    {
        is .($example<in>), $example<out>, $example<name>
    }

    is .("zroezerotowtwotwo"                        ~
         "esveneight"                               ~
         "oneenineninefiv"                          ~
         "zeroonetwothreeeightfivesixsevenninefour" ~
         "ninenineninenine"), 

         "0001122223455677889999999";

    my $time = now;

    is .("ixsoneurfoiennehetrnoeeitghgtiheeonenoxi" ~
         "sgetihevfieviferehtotwowtheterufortgehii" ~
         "thgetegihiegthotweinnfveionetwooenihegte" ~
         "ivffeivixseninisxerzonoexisesevnwtoesnve" ~
         "sevenrfuotwoehtrehteerwotxsiehretsixrteh" ~
         "eurofuofrixsfveiezorroezeivfowtneofurosx" ~
         "isenveefivoenroufteehrsxiveneseninoneoen" ~
         "eerthtowowthtgeienorufoviefiennfievxisrf" ~
         "uotwoixsennizoernienenoerthetihgeozerotw" ~
         "sveenenvesveesnwotvseenufroezorurfoehrte" ~
         "erehtotwxiseinnievfneinneinevfiivfesixzr" ~
         "eoowtnenivesneuofrnneinoesixthiegsxitihg" ~
         "eerhetwotivfeigehtesenvhreetuforxiseghti" ~
         "neseveontgehiofruhiegtehtrewtoforuerzoxi" ~
         "snesevxsievfifevivneesozerwtovsneeviefsx" ~
         "ieorzoezrsxifourhgtietghieievfofureinneh" ~
         "ertoneufroufroefivfoureorznineeonvfienen" ~
         "iwtoefvievfisixvesenrhetefuroorezzreoixs" ~
         "heitgtwoowtienneonehrettoweonxisrethefor" ~
         "uuofrenveszeorefivurfoeevsnowtotweethren" ~
         "sevxsifieverthezeorwotisxtowxsiisxifvein" ~
         "enzorezroeeozrroufixsnienrethesixuofrtwo" ~
         "roezensevninerethetehreourfgiethsixsixuo" ~
         "rfzerovesneesvenrzoeotwroufneoorezetrehe" ~
         "envseerthinenenesvneinozeruorffouroenwto"), 

         "000000000000000000000000111111111111111111" ~
         "111222222222222222222222222222223333333333" ~
         "333333333333333344444444444444444444444444" ~
         "444445555555555555555555555555666666666666" ~
         "666666666666666666667777777777777777777777" ~
         "7788888888888888888888999999999999999999999";

    say "final test == {now - $time} seconds"
}
