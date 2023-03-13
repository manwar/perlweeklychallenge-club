#!/usr/bin/env raku
use Test;

is-deeply(min-index-sum(<Perl Raku Love>, <Raku Perl Hate>), ("Perl", "Raku"), "Example 1");

is-deeply(min-index-sum(<A B C>, <D E F>), (), "Example 2");

is-deeply(min-index-sum(<A B C>, <C A B>), ("A",), "Example 3");

is-deeply(min-index-sum(<V E T Y W J Z A H S D P F N C G X K B R L U O M Q>,
                        <G Q B P W I L N U K T V H C R A J D S O Y F E Z M>,
                        <B J X E P Q T W V H M G D C U N F I Z S O K R A L>,
                        <Z G O E B V A W I J N M Q S T R X P K L F H U Y D>,
                        <Z C P X B O U L W V R M J H E D Y Q F I K A T N G>,
                        <P E B N W R U T X C K Z Q F G S V L D M J H Y A O>,
                        <T A D V K P U S H W Z Q F I N M J C E Y L X R B O>,
                        <K X C F D Y J G A P E H Z M T B L S V U R O I N W>,
                        <Z D G R O P K Y H X B S T I V Q A N L F M U C E W>,
                        <H C Q S J B D Y T W N E M P I V O R F G A L K U Z>), ("V",), "10 X 25");

is-deeply(min-index-sum(<X W F Z S O B R E C A Q L D M V U H Y K G P T J I>,
                        <M R L W X F J I S B D G P Q Z V C O A E N T H Y K>,
                        <Y N D U I J A Q F Z W P O H R S L X T V C E B M K>,
                        <Y T J D V H K R G I E P S O N B C X Z U W M L F Q>,
                        <V E T Y W J Z A H S D P F N C G X K B R L U O M Q>,
                        <G Q B P W I L N U K T V H C R A J D S O Y F E Z M>,
                        <B J X E P Q T W V H M G D C U N F I Z S O K R A L>,
                        <Z G O E B V A W I J N M Q S T R X P K L F H U Y D>,
                        <Z C P X B O U L W V R M J H E D Y Q F I K A T N G>,
                        <P E B N W R U T X C K Z Q F G S V L D M J H Y A O>,
                        <T A D V K P U S H W Z Q F I N M J C E Y L X R B O>,
                        <K X C F D Y J G A P E H Z M T B L S V U R O I N W>,
                        <Z D G R O P K Y H X B S T I V Q A N L F M U C E W>,
                        <H C Q S J B D Y T W N E M P I V O R F G A L K U Z>,
                        <K X P M W G Y J H U F D O L N S V E R A Q I C T Z>,
                        <Q P A O X E Y J R U L B M N S W F V Z D G C I H K>,
                        <U R M K T A H C V S B O Y X G D F Z I W L E J P N>,
                        <I V E Z C K B U O H G J X D L P T Q W Y F N A R M>,
                        <B H P M W N E X C S R A Z I T O F G Y V J U Q D K>,
                        <U X Q P H E D A B F Z K L O G T V C I Y R N J W M>,
                        <U N E V Z I B J F H C Q L S W T Y G P O R M D K X>,
                        <N X H M G J S V L U W Q I T Z A B E F O K R P Y D>,
                        <L O S X A U P R Q M Z J D V F E B N W K T Y I C H>,
                        <Z X S D H T O F L C Q G M P V B K E Y U A R I W J>,
                        <S J C N P X T G B V D F A W M K L O H I Z U Y R E>), ("D", "E", "W"), "25 X 25");

sub min-index-sum(+$a)
{
    my $m := $a>>.antipairs>>.Map;
    my $k := ([(&)] $m).keys;
    ($k Z=> [Z+] $m>>{$k}).Map.minpairs.Map.keys.sort
}
