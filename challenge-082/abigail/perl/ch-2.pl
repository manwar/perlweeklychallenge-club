#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
#   You are given 3 strings; $A, $B and $C.
#   
#   Write a script to check if $C is created by interleave $A and $B.
#   
#   Print 1 if check is success otherwise 0.
#

chomp (my $A = <>);
chomp (my $B = <>);
chomp (my $C = <>);

sub is_interleaved;
sub is_interleaved ($A, $B, $C) {
    #
    # If $A or $B is empty, the other should equal $C.
    # This also takes care of the situation where all strings
    # are empty (which means, they are interleaved).
    # 
    return $A eq $C if !length $B;
    return $B eq $C if !length $A;

    #
    # The length of $C must equal the length of $A plus the
    # length of $B, else $C cannot be an interleaving of $A and $B.
    #
    return unless length ($A) + length ($B) == length ($C);

    #
    # Now, let $A = a . A', $B = b . B', $C = c . C', where
    # a, b, and c are the first characters of the strings 
    # $A, $B, $C, and A', B', C' the rest of the strings.
    # $C is an interleaving of $A and $B if one of the following
    # statements is true:
    #    * a eq c, and C' is an interleaving of  A' and $B.
    #    * b eq c, and C' is an interleaving of $A  and  B'.
    #
    # Note that at this point, none of the strings $A, $B or $C are empty.
    #
    my ($a, $A_prime) = $A =~ /^(.)(.*)$/;
    my ($b, $B_prime) = $B =~ /^(.)(.*)$/;
    my ($c, $C_prime) = $C =~ /^(.)(.*)$/;
    return $a eq $c && is_interleaved ($A_prime, $B,       $C_prime) ||
           $b eq $c && is_interleaved ($A,       $B_prime, $C_prime);
}

say is_interleaved ($A, $B, $C) ? 1 : 0;


__END__
