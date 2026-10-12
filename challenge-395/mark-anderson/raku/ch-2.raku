#!/usr/bin/env raku
use Trie;
use Test;

is-deeply word-square(<MA AM MY ME>),                   <MA AM>;
is-deeply word-square(<SUN USE NET SEE TEN>),           <SUN USE NET>;
is-deeply word-square(<BOAT TEAL AREA TSAR OGRE>),      <BOAT OGRE AREA TEAL>;
is-deeply word-square(<CARD AREA REAR DART>),           <CARD AREA REAR DART>;
is-deeply word-square(<HEART TREND EMBER RESIN ABUSE>), <HEART EMBER ABUSE RESIN TREND>;
is-deeply word-square(<MILIOTABULEL OTISIROMELIR HASINASUOTIR ARIBATINTIRA 
                       NOSIRACILARI INENTINELELA CRATIBARINSI IRAASIMELEIS 
                       SERRAREPINTO APERUNOIBEMI DEMASICOANOC ISICHADAMION>), 
                      <ISICHADAMION SERRAREPINTO IRAASIMELEIS CRATIBARINSI 
                       HASINASUOTIR ARIBATINTIRA DEMASICOANOC APERUNOIBEMI 
                       MILIOTABULEL INENTINELELA OTISIROMELIR NOSIRACILARI>;

sub word-square(@a is copy)
{
    my $trie = Trie.new;
    $trie.insert($_) for @a;

    OUTER-LOOP: for ^@a
    {
        my @res = [[@a.head],];
    
        loop
        {
            return @res.flat(:hammer) if @res.elems == @a.tail.chars;
    
            my @m = $trie.get-all((@res>>.tail)>>.substr(@res.elems,1));
    
            if @m
            {
                @res.push: @m
            }    
    
            else
            {
                try @res.pop while @res.tail.elems == 0|1;
                @res.tail.pop 
            }
    
            unless @res 
            {
                @a .= rotate;
                next OUTER-LOOP
            } 
        }
    }
}
