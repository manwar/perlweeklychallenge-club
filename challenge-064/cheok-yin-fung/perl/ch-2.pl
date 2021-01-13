#!/usr/bin/perl
use strict;
use Math::Combinatorics;
use List::Util qw{sum};

# Usage:
# Example Input: $ perl ch-2.pl perlweeklychallenge weekly challenge perl
#        Output: "perl","weekly","challenge"

#ref Challenge-051 task-1 3 Sum
#brute force

#my $S = "perlweeklychallenge";
#my @W = ("weekly", "challenge", "perl");
my $S;
my @W;

if ($ARGV[0] eq undef) {
    $S = "thequickbrownfoxjumpsoverthelazydogwoo";
    @W = split / /, "theq uickb rownf ox jumps over the lazy dog woo";
} else {
    $S = shift @ARGV;
    @W = @ARGV;
}

my $target = length $S;

my $noofsoln = 0;

for my $r (1..$#W+1) {
    my $subject = Math::Combinatorics->new( count => $r , data => [@W] );
    while (my @tsum = $subject->next_combination) {
        if ($target == sum map {length $_} @tsum) {
            my $psubject = Math::Combinatorics->new( count => $r, data => [@tsum]);
            while (my @ptsum = $psubject->next_permutation) {
                if ( $S eq (join "", @ptsum)) {
                    print "\"";
                    print join "\",\"", @ptsum;
                    print "\"\n";
                    $noofsoln++;
                }
            }
        }
    }
}

print "0\n" if $noofsoln == 0;


=pod
Input

my $S = "thequickbrownfoxjumpsoverthelazydog";
my @W = split / /, "the quick brown fox jumps over the lazy dog";
push @W, "theq", "uickb", "rownf", "ox";

$ time perl ch-2.pl
"the","quick","brown","fox","jumps","over","the","lazy","dog"
"the","quick","brown","fox","jumps","over","the","lazy","dog"
"theq","uickb","rownf","ox","jumps","over","the","lazy","dog"
"theq","uickb","rownf","ox","jumps","over","the","lazy","dog"

real	5m7.153s
user	5m6.496s
sys	0m0.076s


---
on performance

$S = "thequickbrownfoxjumpsoverthelazydog";
@W = split / /, "theq uickb rownf ox jumps over the lazy dog";
$ time perl ch-2.pl
"theq","uickb","rownf","ox","jumps","over","the","lazy","dog"

real	0m2.729s
user	0m2.727s
sys	0m0.001s


$S = "thequickbrownfoxjumpsoverthelazydogwoo";
@W = split / /, "theq uickb rownf ox jumps over the lazy dog woo";
$ time perl ch-2.pl
"theq","uickb","rownf","ox","jumps","over","the","lazy","dog","woo"

real	0m22.516s
user	0m22.499s
sys	0m0.009s



$S = "thequickbrownfoxjumpsoverthelazydogwooyousee";
@W = split / /, "theq uickb rownf ox jumps over the lazy dog woo you see";
$ time perl ch-2.pl
"theq","uickb","rownf","ox","jumps","over","the","lazy","dog","woo","you","see"

real	46m17.928s
user	46m14.609s
sys	0m0.448s




see the performance on single alphabet:

$ time perl ch-2.pl abc a b c
"a","b","c"

real	0m0.019s
user	0m0.015s
sys	0m0.004s


$ time perl ch-2.pl abcd a b c d
"a","b","c","d"

real	0m0.024s
user	0m0.024s
sys	0m0.000s


$ time perl ch-2.pl abcde a b c d e
"a","b","c","d","e"

real	0m0.021s
user	0m0.018s
sys	0m0.004s


$ time perl ch-2.pl abcdef a b c d e f
"a","b","c","d","e","f"

real	0m0.027s
user	0m0.027s
sys	0m0.000s


$ time perl ch-2.pl abcdefg a b c d e f g
"a","b","c","d","e","f","g"

real	0m0.048s
user	0m0.048s
sys	0m0.000s


$ time perl ch-2.pl abcdefgh a b c d e f g h
"a","b","c","d","e","f","g","h"

real	0m0.202s
user	0m0.197s
sys	0m0.004s


$ time perl ch-2.pl abcdefghi a b c d e f g h i
"a","b","c","d","e","f","g","h","i"

real	0m1.692s
user	0m1.691s
sys	0m0.000s


$ time perl ch-2.pl abcdefghij a b c d e f g h i j
"a","b","c","d","e","f","g","h","i","j"

real	0m18.022s
user	0m17.954s
sys	0m0.028s


$ time perl ch-2.pl abcdefghijk a b c d e f g h i j k
"a","b","c","d","e","f","g","h","i","j","k"

real	3m21.870s
user	3m21.691s
sys	0m0.004s

=cut
