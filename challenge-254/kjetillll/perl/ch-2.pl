sub reverse_vowels {
    pop =~ s/[aeiou]/ push @_, $&; $&              /geir
        =~ s/[aeiou]/ $& eq lc$& ? lc pop : uc pop /geir
}

use Test::More;
is( reverse_vowels('Raku')  => 'Ruka' );
is( reverse_vowels('Perl')  => 'Perl' );
is( reverse_vowels('Julia') => 'Jaliu' );
is( reverse_vowels('Uiua')  => 'Auiu' );
is( reverse_vowels('Queue')  => 'Qeueu' );
is( reverse_vowels('Queen')  => 'Qeeun' );
is( reverse_vowels('Audio')  => 'Oidua' );
is( reverse_vowels('Suave')  => 'Seavu' );
is( reverse_vowels('Euouae')  => 'Eauoue' );
is( reverse_vowels('non-antidisestablishmentarianismistically to say the least')
                => 'nan-entedasostablishmintirainasmestically te siy thi laost' );
done_testing;
