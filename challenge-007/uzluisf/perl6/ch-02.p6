#!/usr/bin env perl6
use lib '.';
use ModuleCH02;

sub MAIN(
    Str:D :i($first),  #= First word
    Str:D :s($second), #= Second word
    Str:D :f($file),   #= Word list
) {
    die "$file: Not a file" unless $file.IO.e and $file.IO.f;
    my $result = find-shortest-ladder($first, $second, $file);
    put do if $result {
        $result.join(' → ');
    }
    else {
        "No ladder found between '$first' and '$second' with wordlist '$file'."
    }
}
