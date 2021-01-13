#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(any);
use Scalar::Util qw(looks_like_number);

{
    my @jumps = @ARGV;
    die "$0: expect a list of non negative integers\n"
      if any {
        !looks_like_number( $_ ) || $_ < 0 || int( $_ ) != $_
    }
    @jumps;
    say jump_game( @jumps );
}

sub jump_game(@jumps) {

    # we reached the end!
    return 1 if @jumps == 1;

    my $cur = $jumps[0];

    # we cannot jump further or we jumped over the end of the list.
    # an empty input list will also be considered as *jumped over the end*
    return 0 if !@jumps || $cur == 0;

    # assuming we are allowed to jump exactly $cur positions and no less.
    return jump_game( @jumps[ $cur ... $#jumps ] );
}
