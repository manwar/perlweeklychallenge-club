#!raku

#
# Perl Weekly Challenge 244
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-244/>
#

sub MAIN( *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {

    my $power = 0;
    for @nums.combinations {
	next if ! $_;
	$power +=  $_.min * ( $_.max  ** 2 );
    }

    $power.say;
}
