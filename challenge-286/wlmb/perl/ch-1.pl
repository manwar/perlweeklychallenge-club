#!/usr/bin/env perl
# Perl weekly challenge 286
# Task 1:  Self Spammer
#
# See https://wlmb.github.io/2024/09/08/PWC286/#task-1-self-spammer
use v5.36 ;
no warnings qw( qw ) ;
my @words = qw( #!/usr/bin/env perl # Perl weekly challenge 286 Task 1: Self Spammer See
	     https://wlmb.github.io/2024/09/08/PWC286/#task-1-self-spammer
	     use v5.36 no warnings qw
	     my @words = qw( ) say $words [ rand( 0+@words ) ] ; ) ;
say $words [ rand( 0+@words ) ] ;
