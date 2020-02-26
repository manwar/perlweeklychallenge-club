#!/usr/bin/perl

###########################################################################
# script name: ch-1.pl                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/         #
#                                                                         #
###########################################################################

use strict;
use warnings;
use diagnostics;

sub decode {
    my $message       = $_[0];
    $message          =~ s{ }{}g;
    my $decodedString = '_' x index($message,"\n");
    my @seen          = ();
    my $col           =  0;

  CHAR_LOOP:
    foreach ( split //, $message ) {
        if ( $_ eq "\n") {
            $col = 0;
            next CHAR_LOOP;
        }
        substr($decodedString,$col,1,$_) if ++$seen[$col]{$_} == 2;
        ++$col;
    }
    return $decodedString;
}

my $message1 = <<'EOM';         # End of Message
H x l 4 !
c e - l o
z e 6 l g
H W l v R
q 9 m # o
EOM

my $message2 = <<'EOM';
P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
EOM

print decode($message1), "\n";
print decode($message2), "\n";

__END__
ch-1.pl output:

Hello
PerlRaku
