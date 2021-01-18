#!/usr/bin/env raku

multi MAIN(Str:D $s) 
{
    say reverse-words($s)
}

multi MAIN 
{ 
    use Test;
    plan 2;

    my $tests := "The Weekly Challenge",
                 "Challenge Weekly The",
                 "    Perl and   Raku are  part of the same family  ",
                 "family same the of part are Raku and Perl";

    for $tests -> $s, $r 
    {
        is reverse-words($s), $r, "Example " ~ ++$
    }
}

sub reverse-words(Str:D $s --> Str:D) 
{
    $s.words.reverse.join(" ")
}
