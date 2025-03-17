#!/usr/bin/env perl
# Perl weekly challenge 313
# Task 2:  Reverse Letters
#
# See https://wlmb.github.io/2025/03/17/PWC313/#task-2-reverse-letters
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 S1 S2...
    to reverse the alphabetic letters within the strings Sn
    FIN
for(@ARGV){
    my @letters=grep {/[[:alpha:]]/} my @characters=split "";
    $_=pop @letters # modifies @characters
	for grep {/[[:alpha:]]/} @characters;
    my $output=join "", @characters;
    say "$_ -> $output"
}
