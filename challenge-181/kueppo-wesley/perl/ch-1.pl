#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(fc);

use Test::More;

sub order_sentences {
    my $osentence;
    local $/ = ".";

    while ( my $sentence = <DATA> ) {
        chomp( $sentence );
        next if $sentence =~ m/^\s+$/;

        my $index = -1;
        my @words = grep { length != 0 } split m/(\s)/, $sentence;

        @words[ map { $index++; $_ !~ m/\s/ ? $index : () } @words ] = sort { fc $a cmp fc $b } grep { !m/\s/ } @words;

        $osentence .= join '', @words, '.';
    }

    return $osentence;
}

my $expected = <<'EOL'
	about All all could end he how it think was would. a anyone
	basics bit but equation, for in of see still the the
	There there to uncertainty was were. anywhere be he how it matter much
	No positive, see seen the to to tried wasn't. and be coming
	end going it pretty The to was wasn't.
EOL
    ;

is( order_sentences . "\n", $expected, "Are sentences ordered" );

done_testing( 1 );

__DATA__
	All he could think about was how it would all end. There was
	still a bit of uncertainty in the equation, but the basics
	were there for anyone to see. No matter how much he tried to
	see the positive, it wasn't anywhere to be seen. The end was
	coming and it wasn't going to be pretty.
