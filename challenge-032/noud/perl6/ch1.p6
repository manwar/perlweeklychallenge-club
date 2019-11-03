# Count instances
#
# Create a script that either reads standard input or one or more files
# specified on the command-line. Count the number of times and then print a
# summary, sorted by the count of each entry.
#
# So with the following input in file example.txt
#
# apple
# banana
# apple
# cherry
# cherry
# apple
#
# the script would display something like:
#
# apple     3
# cherry    2
# banana    1
#
# For extra credit, add a -csv option to your script, which would generate:
#
# apple,3
# cherry,2
# banana,1

sub MAIN(*@files, Bool :$csv) {
    my %word_count;
    for @files -> $file {
        for $file.IO.words -> $word {
            %word_count{$word}++;
        }
    }

    my $infix = gather { if $csv { take "," } else { take ":\t" } };
    for %word_count.sort(-*.value)>>.kv -> ($word, $count) {
        say "$word$infix$count";
    }
}
