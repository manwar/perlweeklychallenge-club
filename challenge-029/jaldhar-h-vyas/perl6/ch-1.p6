#!/usr/bin/perl6

sub expand(Str $string) {
    $string ~~ / \{(.+)\} /;
 
    return $0.split(/\,\s*/).map({
        my $word = $_;
        (my $expansion = $string) ~~ s/\{.+\}/$word/;
        $expansion;
    });
}

sub MAIN(Str $string) {
    .say for expand($string);
}