#!/usr/bin/perl
# Create a script that either reads standard input or one or more 
# files specified on the command-line. Count the number of times 
# and then print a summary, sorted by the count of each entry.
# So with the following input in file example.txt
# apple
# banana
# apple
# cherry
# cherry
# apple
# the script would display something like:
# apple     3
# cherry    2
# banana    1
# For extra credit, add a -csv option to your script, which would generate:
# apple,3
# cherry,2
# banana,1
use strict;
use warnings;
use feature 'say';

my @files;
my $csv_flag = 0;
my $longest  = 0;
for my $arg (@ARGV) {
    if ($arg eq '-csv') {
        $csv_flag = 1;
    } else {
        push @files, $arg;
    }
}

my %dictionary;
if (@ARGV < ($csv_flag+1)) {
    say "Type the word(s) then press enter, :end to quit:";
    while (chomp(my $word = <STDIN>)) {
        ($word =~ /^:end$/) && last;
        $longest = length $word if $longest < length $word;
        $dictionary{$word}++;
    }
} else {
    for my $text (@files) {
        open my $handle, '<', $text;
        chomp(my @lines = <$handle>);
        close $handle;

        for my $word (@lines) {
            $longest = length $word if $longest < length $word;
            $dictionary{$word}++;
        }
    }
}

$longest = 0 if $csv_flag;

for my $keys (sort { $dictionary{$b}-$dictionary{$a} } sort keys %dictionary) {
    printf ("%-${longest}s%s%s\n",$keys,$csv_flag?",":"  ",$dictionary{$keys});
}
=begin
perl .\ch-1.pl
Type the word(s) then press enter, :end to quit:
a
quick
brown
apple
jumps
over
dog
brown
cat
apple
:end
apple   2
brown   2
a       1
cat     1
dog     1
jumps   1
over    1
quick   1

perl .\ch-1.pl .\sample.txt
apple   2
brown   2
dog     2
a       1
banana  1
black   1
cat     1
fox     1
jumps   1
lazy    1
over    1
quick   1
test    1
the     1

perl .\ch-1.pl -csv .\sample.txt
apple,2
brown,2
dog,2
a,1
banana,1
black,1
cat,1
fox,1
jumps,1
lazy,1
over,1
quick,1
test,1
the,1
=cut