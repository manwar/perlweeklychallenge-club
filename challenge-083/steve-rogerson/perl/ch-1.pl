use strict;
use warnings;
use utf8;
use 5.028;
use feature qw(signatures);
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)
#
# "You are given a string $S with 3 or more words. 
#    Write a script to find the length of the string 
#    except the first and last words ignoring whitespace."
#
# A string ok, so what's a word? In the land of perl regex , a word character is alphanumeric + _.
# So .. if there are three words we drop the outside two - then strip any white space and return the result.

my @strings = (
    "Two words",
    "One Two Three",
    "pre/mid/post",
    "pre/ mid/post",
    "pre/\x{A0}mid/post", # non-breaking space just for fun.
    "pre/ mid mid2/post",
    "pre/ mid mid2/post",
    "pre/ mid\n mid2/post",
);

for my $string (@strings) {
    my $len = find_middle_string_length($string);
    if ( !$len ) {
        say "No middle ";
        next;
    }
    say "The middle bit length, ignoring white space is  " . $len;
}

sub find_middle_string_length($string) {
    my ($middle) = $string =~ /
    \A\W*  # skip leading junk before first word.
    \w+   # The first word.
    \W+  # at least one not word char
    (.*) # everything else (inc c-r with s modifier)
    \W+  # at least one not word char
    \w+ # the final word
    \W* # optional junk
    \z /msx;

    # end of string. Match on multi-line and have c-r included  in ",*" match

    return 0 if !$middle;

    # Strip out white space.
    $middle =~ s/\s//mgx;
    return length($middle);
}
