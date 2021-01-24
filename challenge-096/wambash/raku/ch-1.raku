#!/usr/bin/env raku

sub reverse-words ( $s ) {
    ~$s.words.reverse
}

multi MAIN ( Bool :$test! ) {
    use Test;
    is reverse-words('The Weekly Challenge'), 'Challenge Weekly The';
    is reverse-words('    Perl and   Raku are  part of the same family  '), 'family same the of part are Raku and Perl';
    done-testing;
}

multi MAIN ( *@s ) {
    say reverse-words ~@s
}
