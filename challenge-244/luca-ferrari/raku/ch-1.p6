#!raku

#
# Perl Weekly Challenge 244
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-244/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {
    my @result;
    @result[ $_ ] = @nums.grep( * > @nums[ $_ ] ).elems  for 0 ..^ @nums.elems;
    @result.say;
}
