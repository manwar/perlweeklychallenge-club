use v6;

sub function_builder (Str $letter) {
    my $file_name = "letter_$letter.txt";
    my $fh = open "./$file_name", :w;
    return { $fh.say($^a) }
}

multi sub MAIN (Str $file where *.IO.f) {
    my %dispatch;
    for $file.IO.words.map({.lc}) -> $word {
        my $letter = substr $word, 0, 1;
        next if $letter !~~ /^<[a..z]>/;
        %dispatch{$letter} = function_builder $letter unless defined %dispatch{$letter};
        %dispatch{$letter}($word);
    }
}
