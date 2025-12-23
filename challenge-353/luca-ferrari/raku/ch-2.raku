#!raku

#
# Perl Weekly Challenge 353
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-353>
#

sub MAIN(  :@codes,  :@names,  :@status ) {

    my @valid;

    for 0 ..^ @codes.elems  {
	@valid[ $_ ] = False and next unless ( @codes[ $_ ] );
	@valid[ $_ ] = False and next unless ( @codes[ $_ ] ~~ / ^ <[a..zA..Z0..9_]>+ $ / );
	@valid[ $_ ] = False and next unless ( @names[ $_ ] ~~ / electronics|grocery|pharmacy|restaurant / );
	@valid[ $_ ] = False and next unless ( @status[ $_ ].so );
	@valid[ $_ ] = True;
    }

    @valid.say;

}

