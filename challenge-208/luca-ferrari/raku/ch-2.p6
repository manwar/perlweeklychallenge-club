#!raku

#
# Perl Weekly Challenge 208
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-208/>
#

sub MAIN( *@list where { @list.grep( * ~~ Int ).elems == @list.elems } ) {
    my %results;

    for @list.min .. @list.max {
	%results{ $_ } += @list.grep( $_ ).elems;
    }


    for %results.keys.sort {
	"Duplicated value $_ (found { %results{ $_ } } times)".say if ( %results{ $_ } > 1 );
	"Missing value $_".say if ( %results{ $_ } == 0 );
    }
}
