#!/usr/bin/env perl
use warnings;
use strict;

use Inline C => <<'__END__';

int wgetuid() {
	return getuid();
}
__END__

print "User ID: ".wgetuid()."\n";

