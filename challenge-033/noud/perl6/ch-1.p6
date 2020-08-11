# Count Letters (A..Z)
#
# Create a script that accepts one or more files specified on the command-line
# and count the number of times letters appeared in the files.
#
# So with the following input file sample.txt
#
# The quick brown fox jumps over the lazy dog.
#
# the script would display something like:
#
# a: 1
# b: 1
# c: 1
# d: 1
# e: 3
# f: 1
# g: 1
# h: 2
# i: 1
# j: 1
# k: 1
# l: 1
# m: 1
# n: 1
# o: 4
# p: 1
# q: 1
# r: 2
# s: 1
# t: 2
# u: 2
# v: 1
# w: 1
# x: 1
# y: 1
# z: 1

sub MAIN(*@files) {
    my %letter_count;
    %letter_count<a b c d e f g h i j k l m
                  n o p q r s t u v w x y z> = 0 xx *;

    for @files -> $file {
        for $file.IO.comb -> $letter {
            if (%letter_count{$letter.lc}:exists) {
                %letter_count{$letter.lc}++;
            }
        }
    }

    for %letter_count.sort(*.key)>>.kv -> ($letter, $count) {
        say "$letter: $count";
    }
}
