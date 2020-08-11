#!/usr/bin/perl
use strict;
use Inline C => <<'EOC';
 
void pwc() {
	printf("Perl Weekly Challenge 029 Inline-C example!\n");
}
EOC

pwc();

__END__

./ch-2.pl
Perl Weekly Challenge 029 Inline-C example!

