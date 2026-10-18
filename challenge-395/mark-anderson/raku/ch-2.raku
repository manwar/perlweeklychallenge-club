#!/usr/bin/env raku
use Trie;
use Test;

is-deeply word-square(<MA AM MY ME>),                   (<MA AM>, <AM MY>, <AM ME>, <AM MA>);
is-deeply word-square(<SUN USE NET SEE TEN>),           (<SUN USE NET>,);
is-deeply word-square(<BOAT TEAL AREA TSAR OGRE>),      (<BOAT OGRE AREA TEAL>,);
is-deeply word-square(<CARD AREA REAR DART>),           (<CARD AREA REAR DART>,);
is-deeply word-square(<HEART TREND EMBER RESIN ABUSE>), (<HEART EMBER ABUSE RESIN TREND>,);

is-deeply word-square(<MILIOTABULEL OTISIROMELIR HASINASUOTIR ARIBATINTIRA 
                       NOSIRACILARI INENTINELELA CRATIBARINSI IRAASIMELEIS 
                       SERRAREPINTO APERUNOIBEMI DEMASICOANOC ISICHADAMION>), 
                      (<ISICHADAMION SERRAREPINTO IRAASIMELEIS CRATIBARINSI 
                       HASINASUOTIR ARIBATINTIRA DEMASICOANOC APERUNOIBEMI 
                       MILIOTABULEL INENTINELELA OTISIROMELIR NOSIRACILARI>,);

# My word list (/usr/share/dict/words) has 14687 word squares
# with "RAKU" included. There are 3224 word squares with "RAKU"
# as the first word. Below is a small sample.

is-deeply word-square(<ABEL ABET ABIR ACER ACES ACID AFAR AGAG AGES AGUA
                       AHEM AHIR AIAS AINT AJAR AKAL AKAN ALES AMEN AMIR
                       ANON AQUA AREA ARES ATOP AUNT AVAL AVES AVIS AVON
                       AXEL AXER AXES AXIS AXON KAHN KAHU KAIL KAKI KALE
                       KALI KAPA KAVI KEEN KEEP KEGS KEID KELD KELE KELP
                       KELT KEMP KEND KENO KENS KEPI KERN KETA KEYS KIDS
                       KIEV KIKI KILO KIND KING KISS KITE KITS KIWI KNEE
                       KOBI KOLI KOPI KOSO KUAN KUAR RAKU UANG UART UGLY
                       ULAN ULNA ULPS ULUA UMPH UNDO UNIT UNIX UNTO UPON
                       UREA URGE URIA URIC URIS URNA URNS UROL URSA URVA
                       USDA USED USER USES USPS USSR UTAH UTEP YARD ZERO>),

                     (<RAKU AXON KOPI UNIX>,
                      <RAKU AXON KOPI UNIT>,
                      <RAKU AXON KOLI UNIX>,
                      <RAKU AXON KOLI UNIT>,
                      <RAKU AXON KOBI UNIX>,
                      <RAKU AXON KOBI UNIT>,
                      <RAKU AXIS KITS USSR>,
                      <RAKU AXIS KITE USES>,
                      <RAKU AXIS KITE USER>,
                      <RAKU AXIS KITE USED>,
                      <RAKU AXIS KISS USSR>,
                      <RAKU AXIS KIND USDA>,
                      <RAKU AXIS KIDS USSR>,
                      <RAKU AXES KEYS USSR>,
                      <RAKU AXES KENS USSR>,
                      <RAKU AXES KEND USDA>,
                      <RAKU AXES KEMP USPS>,
                      <RAKU AXES KELP USPS>,
                      <RAKU AXES KELE USES>,
                      <RAKU AXES KELE USER>,
                      <RAKU AXES KELE USED>,
                      <RAKU AXES KELD USDA>,
                      <RAKU AXES KEID USDA>,
                      <RAKU AXES KEGS USSR>,
                      <RAKU AXES KEEP USPS>,
                      <RAKU AXER KEYS URSA>,
                      <RAKU AXER KERN URNS>,
                      <RAKU AXER KERN URNA>,
                      <RAKU AXER KEPI URIS>,
                      <RAKU AXER KEPI URIC>,
                      <RAKU AXER KEPI URIA>,
                      <RAKU AXER KENS URSA>,
                      <RAKU AXER KENO UROL>,
                      <RAKU AXER KELE UREA>,
                      <RAKU AXER KEGS URSA>,
                      <RAKU AXER KEEN URNS>,
                      <RAKU AXER KEEN URNA>,
                      <RAKU AXEL KETA ULAN>,
                      <RAKU AXEL KERN ULNA>,
                      <RAKU AXEL KEMP ULPS>,
                      <RAKU AXEL KELP ULPS>,
                      <RAKU AXEL KEEP ULPS>,
                      <RAKU AXEL KEEN ULNA>,
                      <RAKU AVON KOPI UNIX>,
                      <RAKU AVON KOPI UNIT>,
                      <RAKU AVON KOLI UNIX>,
                      <RAKU AVON KOLI UNIT>,
                      <RAKU AVON KOBI UNIX>,
                      <RAKU AVON KOBI UNIT>,
                      <RAKU AVIS KITS USSR>,
                      <RAKU AVIS KITE USES>,
                      <RAKU AVIS KITE USER>,
                      <RAKU AVIS KITE USED>,
                      <RAKU AVIS KISS USSR>,
                      <RAKU AVIS KIND USDA>,
                      <RAKU AVIS KIDS USSR>,
                      <RAKU AVES KEYS USSR>,
                      <RAKU AVES KENS USSR>,
                      <RAKU AVES KEND USDA>,
                      <RAKU AVES KEMP USPS>,
                      <RAKU AVES KELP USPS>,
                      <RAKU AVES KELE USES>,
                      <RAKU AVES KELE USER>,
                      <RAKU AVES KELE USED>,
                      <RAKU AVES KELD USDA>,
                      <RAKU AVES KEID USDA>,
                      <RAKU AVES KEGS USSR>,
                      <RAKU AVES KEEP USPS>,
                      <RAKU AVAL KAPA ULAN>,
                      <RAKU AVAL KAHU ULUA>,
                      <RAKU AVAL KAHN ULNA>,
                      <RAKU AUNT KNEE UTEP>,
                      <RAKU ATOP KOSO UPON>,
                      <RAKU ARES KEYS USSR>,
                      <RAKU ARES KENS USSR>,
                      <RAKU ARES KEND USDA>,
                      <RAKU ARES KEMP USPS>,
                      <RAKU ARES KELP USPS>,
                      <RAKU ARES KELE USES>,
                      <RAKU ARES KELE USER>,
                      <RAKU ARES KELE USED>,
                      <RAKU ARES KELD USDA>,
                      <RAKU ARES KEID USDA>,
                      <RAKU ARES KEGS USSR>,
                      <RAKU ARES KEEP USPS>,
                      <RAKU AREA KERN UANG>,
                      <RAKU AREA KEEN UANG>,
                      <RAKU AQUA KUAR UART>,
                      <RAKU AQUA KUAN UANG>,
                      <RAKU ANON KOPI UNIX>,
                      <RAKU ANON KOPI UNIT>,
                      <RAKU ANON KOLI UNIX>,
                      <RAKU ANON KOLI UNIT>,
                      <RAKU ANON KOBI UNIX>,
                      <RAKU ANON KOBI UNIT>,
                      <RAKU AMIR KIWI URIS>,
                      <RAKU AMIR KIWI URIC>,
                      <RAKU AMIR KIWI URIA>,
                      <RAKU AMIR KITS URSA>,
                      <RAKU AMIR KITE UREA>,
                      <RAKU AMIR KISS URSA>,
                      <RAKU AMIR KING URGE>,
                      <RAKU AMIR KILO UROL>,
                      <RAKU AMIR KIKI URIS>,
                      <RAKU AMIR KIKI URIC>,
                      <RAKU AMIR KIKI URIA>,
                      <RAKU AMIR KIEV URVA>,
                      <RAKU AMIR KIDS URSA>,
                      <RAKU AMEN KEPI UNIX>,
                      <RAKU AMEN KEPI UNIT>,
                      <RAKU AMEN KEND UNDO>,
                      <RAKU AMEN KELT UNTO>,
                      <RAKU AMEN KELD UNDO>,
                      <RAKU AMEN KEID UNDO>,
                      <RAKU ALES KEYS USSR>,
                      <RAKU ALES KENS USSR>,
                      <RAKU ALES KEND USDA>,
                      <RAKU ALES KEMP USPS>,
                      <RAKU ALES KELP USPS>,
                      <RAKU ALES KELE USES>,
                      <RAKU ALES KELE USER>,
                      <RAKU ALES KELE USED>,
                      <RAKU ALES KELD USDA>,
                      <RAKU ALES KEID USDA>,
                      <RAKU ALES KEGS USSR>,
                      <RAKU ALES KEEP USPS>,
                      <RAKU AKAN KAVI UNIX>,
                      <RAKU AKAN KAVI UNIT>,
                      <RAKU AKAN KALI UNIX>,
                      <RAKU AKAN KALI UNIT>,
                      <RAKU AKAN KAKI UNIX>,
                      <RAKU AKAN KAKI UNIT>,
                      <RAKU AKAL KAPA ULAN>,
                      <RAKU AKAL KAHU ULUA>,
                      <RAKU AKAL KAHN ULNA>,
                      <RAKU AJAR KAVI URIS>,
                      <RAKU AJAR KAVI URIC>,
                      <RAKU AJAR KAVI URIA>,
                      <RAKU AJAR KALI URIS>,
                      <RAKU AJAR KALI URIC>,
                      <RAKU AJAR KALI URIA>,
                      <RAKU AJAR KALE UREA>,
                      <RAKU AJAR KAKI URIS>,
                      <RAKU AJAR KAKI URIC>,
                      <RAKU AJAR KAKI URIA>,
                      <RAKU AJAR KAHN URNS>,
                      <RAKU AJAR KAHN URNA>,
                      <RAKU AINT KNEE UTEP>,
                      <RAKU AIAS KALE USES>,
                      <RAKU AIAS KALE USER>,
                      <RAKU AIAS KALE USED>,
                      <RAKU AHIR KIWI URIS>,
                      <RAKU AHIR KIWI URIC>,
                      <RAKU AHIR KIWI URIA>,
                      <RAKU AHIR KITS URSA>,
                      <RAKU AHIR KITE UREA>,
                      <RAKU AHIR KISS URSA>,
                      <RAKU AHIR KING URGE>,
                      <RAKU AHIR KILO UROL>,
                      <RAKU AHIR KIKI URIS>,
                      <RAKU AHIR KIKI URIC>,
                      <RAKU AHIR KIKI URIA>,
                      <RAKU AHIR KIEV URVA>,
                      <RAKU AHIR KIDS URSA>,
                      <RAKU AHEM KEMP UMPH>,
                      <RAKU AHEM KELP UMPH>,
                      <RAKU AHEM KEEP UMPH>,
                      <RAKU AGUA KUAR UART>,
                      <RAKU AGUA KUAN UANG>,
                      <RAKU AGES KEYS USSR>,
                      <RAKU AGES KENS USSR>,
                      <RAKU AGES KEND USDA>,
                      <RAKU AGES KEMP USPS>,
                      <RAKU AGES KELP USPS>,
                      <RAKU AGES KELE USES>,
                      <RAKU AGES KELE USER>,
                      <RAKU AGES KELE USED>,
                      <RAKU AGES KELD USDA>,
                      <RAKU AGES KEID USDA>,
                      <RAKU AGES KEGS USSR>,
                      <RAKU AGES KEEP USPS>,
                      <RAKU AGAG KAIL UGLY>,
                      <RAKU AFAR KAVI URIS>,
                      <RAKU AFAR KAVI URIC>,
                      <RAKU AFAR KAVI URIA>,
                      <RAKU AFAR KALI URIS>,
                      <RAKU AFAR KALI URIC>,
                      <RAKU AFAR KALI URIA>,
                      <RAKU AFAR KALE UREA>,
                      <RAKU AFAR KAKI URIS>,
                      <RAKU AFAR KAKI URIC>,
                      <RAKU AFAR KAKI URIA>,
                      <RAKU AFAR KAHN URNS>,
                      <RAKU AFAR KAHN URNA>,
                      <RAKU ACES KEYS USSR>,
                      <RAKU ACES KENS USSR>,
                      <RAKU ACES KEND USDA>,
                      <RAKU ACES KEMP USPS>,
                      <RAKU ACES KELP USPS>,
                      <RAKU ACES KELE USES>,
                      <RAKU ACES KELE USER>,
                      <RAKU ACES KELE USED>,
                      <RAKU ACES KELD USDA>,
                      <RAKU ACES KEID USDA>,
                      <RAKU ACES KEGS USSR>,
                      <RAKU ACES KEEP USPS>,
                      <RAKU ACER KEYS URSA>,
                      <RAKU ACER KERN URNS>,
                      <RAKU ACER KERN URNA>,
                      <RAKU ACER KEPI URIS>,
                      <RAKU ACER KEPI URIC>,
                      <RAKU ACER KEPI URIA>,
                      <RAKU ACER KENS URSA>,
                      <RAKU ACER KENO UROL>,
                      <RAKU ACER KELE UREA>,
                      <RAKU ACER KEGS URSA>,
                      <RAKU ACER KEEN URNS>,
                      <RAKU ACER KEEN URNA>,
                      <RAKU ABIR KIWI URIS>,
                      <RAKU ABIR KIWI URIC>,
                      <RAKU ABIR KIWI URIA>,
                      <RAKU ABIR KITS URSA>,
                      <RAKU ABIR KITE UREA>,
                      <RAKU ABIR KISS URSA>,
                      <RAKU ABIR KING URGE>,
                      <RAKU ABIR KILO UROL>,
                      <RAKU ABIR KIKI URIS>,
                      <RAKU ABIR KIKI URIC>,
                      <RAKU ABIR KIKI URIA>,
                      <RAKU ABIR KIEV URVA>,
                      <RAKU ABIR KIDS URSA>,
                      <RAKU ABET KETA UTAH>,
                      <RAKU ABET KELE UTEP>,
                      <RAKU ABEL KETA ULAN>,
                      <RAKU ABEL KERN ULNA>,
                      <RAKU ABEL KEMP ULPS>,
                      <RAKU ABEL KELP ULPS>,
                      <RAKU ABEL KEEP ULPS>,
                      <RAKU ABEL KEEN ULNA>);

sub word-square(@a)
{
    my $trie = Trie.new;
    $trie.insert($_) for @a;

    gather for @a -> $head
    {
        my @stack = [[$head],];
    
        while @stack
        {
            my @m = $trie.get-all((@stack>>.tail)>>.substr(@stack.elems,1));
    
            if @m
            {
                @stack.push: @m; 

                next unless @stack.elems == $head.chars;
            
                while @stack.tail
                {
                    take @stack>>.tail;
                    @stack.tail.pop
                }
            }

            try @stack.pop while @stack.tail.elems == 0|1;
            try @stack.tail.pop 
        }
    }
}
