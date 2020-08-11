my $minimum_length = 1;

multi sub MAIN(
    Str $words, #= Space/Comma separated words enclosed with ""
    *@files     #= File(s) to search
) {
    # Get the words to search. Convert it to lowercase. 
    # Get only unique words (with Set).
    my Str @words = (map {.lc},$words.split(/<[\s,]>/)).Set.keys;

    # Create index from files
    my %index;
    for @files -> $file {
        for $file.IO.lines -> $line {
            %index{ .lc }{ $file.subst(/^\.\\/,'') }++ for $line.split(/\W/).grep(/^ \w ** {$minimum_length..*} $/)
        }
    }
    
    #Show search result
    for @words.sort -> $w {
        my @f;
        for %index{$w}.keys.sort -> $f {
            @f.push($f)
        }
        say "$w:\t"~(@f[] || "(N/A)")
    }

} 
#`[
# perl6 .\ch-2.p6 "i sing eat and love" .\file1.txt .\file2.txt .\file3.txt .\file4.txt .\file5.txt 
# and:    file1.txt file2.txt
# eat:    file4.txt
# i:      file1.txt file2.txt file4.txt
# love:   file2.txt file5.txt
# sing:   (N/A)
# ]

