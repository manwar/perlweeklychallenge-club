use v6;
unit sub MAIN(IO:D(Str:D) $input --> Nil);
my $paragraph = $input.slurp;
put gather while $paragraph -> $_ is raw {
    s/ ^ <:Z+:C>+ //;
    push state @sentence, $/ when s/ ^ <:!Z+:!C+:!Sentence_Terminal>+ //;
    take @sentence.splice.sort(*.lc leg *.lc) ~ $/ when s/ ^ <:Sentence_Terminal>+ //;
}
