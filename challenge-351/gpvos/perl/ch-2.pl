#!/usr/bin/perl -w

use v5.34;
use strict;
use List::Util qw(all);
use List::MoreUtils qw(slide);

say is_arith_prog(<>) ? 'true' : 'false';
exit;

sub is_arith_prog {
	return (@_ <= 2) || (
		all { $_ == 0 }
		slide { $b - $a }
		slide { $b - $a }
		sort { $a <=> $b } @_
	);
}

