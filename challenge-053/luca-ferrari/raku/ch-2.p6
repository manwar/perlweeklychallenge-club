#!env raku
#
# Perl Weekly Challenge 53
# <https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/>
#
# Task 2
#
# Write a script to accept an integer 1 <= N <= 5 that would
# print all possible strings of size N formed
# by using only vowels (a, e, i, o, u).
# 
#     The string should follow the following rules:
# 
#     ‘a’ can only be followed by ‘e’ and ‘i’.
# 
#     ‘e’ can only be followed by ‘i’.
# 
#     ‘i’ can only be followed by ‘a’, ‘e’, ‘o’, and ‘u’.
# 
#     ‘o’ can only be followed by ‘a’ and ‘u’.
# 
#     ‘u’ can only be followed by ‘o’ and ‘e’.
# 
#     For example, if the given integer N = 2 then script
#     should print the following strings:
# 
#     ae
#     ai
#     ei
#     ia
#     io
#     iu
#     ie
#     oa
#     ou
#     uo
#     ue
#



sub MAIN( Int:D $size where { 1 < $size <= 5 } = 2 ) {
    say "Requested string length is $size ";
    my @vowels = 'a', 'e', 'i', 'o', 'u';

    # build a matrix with all the possibile combinations
    my @combinations = @vowels;
    for 1 ..^ $size {
        @combinations = @combinations [X] @vowels;
    }



    for @combinations -> @letters {
        my $string = @letters.join;
        my $ok = True;

        # test if all but the last letters do match the regular expression
        loop ( my $i = 0; $i < @letters.elems - 1; $i++ ) {
            my $letter = @letters[ $i ];
            $ok = do 
                given $letter {
                    when 'a' { $string ~~ / a (e | i) / }
                    when 'e' { $string ~~ / ei / }
                    when 'i' { $string ~~ / i ( a | e | o | u ) / }
                    when 'o' { $string ~~ / o ( a | u ) / }
                    when 'u' { $string ~~ /u ( o | e ) / }
            }.so;

            # if not ok, do not continue
            last if ! $ok;
        }

        say "Found { ~@letters }" if $ok;
    }

}
