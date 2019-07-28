# Write a script that takes 2 or more strings as command line parameters
# and print the longest common substring. For example, the longest common
# substring of the strings “ABABC”, “BABCA” and “ABCBA” is string “ABC”
# of length 3. Other common substrings are “A”, “AB”, “B”, “BA”, “BC”
# and “C”. Please check this wiki page for details.

use strict;
use warnings;
use v5.10;
use utf8;
use open qw(:std :utf8);
use FindBin;
use Encode 'decode_utf8';    # ¡Porque hay otros idiomas! :)

# we start by writing a function that gives all possible substrings of size
# $n from a given string

sub substrings {
    my ( $s, $n ) = @_;
    my @r;    # array of all subrstrings
    for my $i ( 0 .. length($s) - $n ) {

        # will end up pushing all possible $n char substrings
        push @r, substr $s, $i, $n;
    }
    return @r;
}

# we will use first input string as a reference, because it should
# always exist

my ( $ref, @others ) = @ARGV;

die "Usage: perl $0 <string1> <string2> ... <stringn>" unless defined $ref;

# now we will start with length($ref) chars, and go back to 1 char, checking
# if any substring from $ref exists in other strings

for my $i ( reverse 1 .. length($ref) ) {

   # we now construct a hash with all substrings of $n chars of $ref, like this:
    my %ref_substrings = map { $_ => 0 } substrings( $ref, $i );

    # 0 means it didn't match any other substring yet
    for my $oth (@others) {
        for my $oth_sstr ( substrings( $oth, $i ) ) {
            next unless exists $ref_substrings{$oth_sstr};
            $ref_substrings{$oth_sstr} = 1;
        }

        # everytime after matching other strings, delete all non-matched
        # and prepare %ref_substrings for next string
        for my $k ( keys %ref_substrings ) {
            if ( $ref_substrings{$k} ) {

                # keep this one, but mark as not matched for next string check
                $ref_substrings{$k} = 0;
            }
            else {
                # delete this one, not matched
                delete $ref_substrings{$k};
            }
        }
    }

    # after looking on all @others, any remaining match is the correct answer!
    for my $m ( keys %ref_substrings ) {
        say "Found substring $m with $i chars in all strings";
    }
    last
      if %ref_substrings;    # and don't look any further
                             # (would get shorter matches)
}
