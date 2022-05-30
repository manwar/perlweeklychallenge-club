#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

constant $dictionary = $?FILE.IO.parent(5).add("data/dictionary.txt");

=begin comment
Task 1: Hexadecimal Words
Submitted by: Ryan J Thompson
A program that will read from a dictionary and find 2- to 8-letter words
that can be “spelled” in hexadecimal using the following letter substitutions:
    o ⟶ 0   l ⟶ 1   i ⟶ 1   s ⟶ 5   t ⟶ 7
Using the provided data/dictionary.txt.
 
My extension (enabled by an 'e' option) also uses these transliterations:
    nine ⟶ 9    eight⟶ 8    two ⟶ 2     too ⟶ 2     to ⟶ 2
    ate  ⟶ 8     four ⟶ 4    for ⟶ 4     six ⟶ 6
for a more 0xA519 encoding.  (I don't think there be words that will use
the 'eight' but neologisms are an ill defined horde).

=end comment

my regex hexable   { :i  ^ <[olistabcdef]>**2..8 $ };  # XXX magic
my regex extended-hexable {
    :i  ^ <[ghnruwxolistabcdef]>**2..19 $               # XXX "
};

sub MAIN( Bool :$extended) {

    if $extended {
        for $dictionary.words -> Str $w {
            if $w ~~ /<&extended-hexable>/ {
                my $word = extended-hexword-ize( $w.lc);
                next unless $word.defined;
                next if $word.chars > 8;                 # XXX magic
                say $word;
            }
        }
     }else{
        for $dictionary.words -> Str $w {
            if $w ~~ / <&hexable> / {
                say hexword-ize( $w.lc);
             }
         }
     }
}

sub hexword-ize(  $word --> Str ) {
    TR/listo/11570/ with $word;      # XXX SPoT 11570
}

sub extended-hexword-ize(  $word is copy --> Str ) {
    for $word {
        # fall through
        when /eight/ { s:g/eight/8/; }
        when /two/   { s:g/two/2/;   }
        when /too/   { s:g/too/2/;   }
        when /to/    { s:g/to/2/;    }
        when /nine/  { s:g/nine/9/;  }
        when /ate/   { s:g/ate/8/;   }
        when /fore/  { s:g/fore/4/;  }
        when /four/  { s:g/four/4/;  }
        when /for/   { s:g/for/4/;   }
        when /six/   { s:g/six/6/;   }
    }

    return Str if $word ~~ / g|h|w|n|u|r|x /;

    $word ~~ tr/listo/11570/;       # XXX SPoT 11570
    $word
}
