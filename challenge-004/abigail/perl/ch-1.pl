#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl
#

my $first_ord  = 1 + ord ('"');
my $range      = 60;

print "3.";
while (<DATA>) {
    foreach (/.{6}/g) {
        my $out = 0;
        foreach (/./g) {
            $out *= $range;
            $out += ord () - $first_ord;
        }
        print $out;
    }
}
print "\n"

#
# Encoded digits of PI below __DATA__
# Encoding is in base-60; from character '#'
#

__DATA__
$T2/ZF.CU[H=&:\X*^)?$KCV+Z@7<-*@+\@'*H$J@;#SA3Y^.(OG7<':]P.6
-DVB4B'02VUR$/;J?2)A4L^C)XC'?S).0\8M-S[=,X-\@DP^+4:J5,*&UN[G
(LNP32+DU2*L&JN-0N'W.;/P&@2II.(W0FOW'>#*[U(UDI?%$N7OIQ#60<YD
,6(LL)#SNX#4)3JI%#/9Z<M7.RKT#G-+^Q/K#+ODLP)3M''/$QS(2V/)?A$E
'2'4AG*;;QJ0$.*WCX-C.PW^&^FCZS#\>6[J+'-NC2%<A7/'.>KD,L-KB>?C
/IQ2[%(K#Q0U.&ON.E+0>B5\%>+S3I*U1KH\#LG9C[&Q/^W&-X854=,VQA5W
##=5*V(T28+%-#P12M,OMV+.,?.4./$X572$%XEAI8(^-O%4$8'QOJ+VU+*2
(;0L#.%O3E^7.)LFG8*LB@M\)+,:WK)K108X)<S+UH&TR3(V#Q(8?S%'.^\J
)>L:-Z'>KE-=(?)20P'5'J-F&9)=I$,*Z#(0-'UB8=*D7GL:-?1NSH,VP5LN
*LGZ2'&LWN$0$@?7RN.7TMOF/&:L%]%:7U+W%/*-$)$K6;JR+A*:5@%Q^>0,
'X[LF7$9/S4N&F->G$)VXSD3-F&1^/#>17M,+W9@3%&7E6;V&/L.FW-O*OPV
*-,B>9(U<@MJ)C/.?B+T>2AZ.=#X&&-AT9,))8*0*F#QG784#/XKBK/J[;=W
.%5\R2+.E40A)&=:W9/47DX,)#VQFO/,$Z9^,\Q^$.#B0VB'*^#\;O&6X\?C
/##QF%.DG=LO,K96%T+@=LGN-?W9IB&2AK(#'EFPDO,I<XL&.P;%<=#C[S\^
+N6R=8+-OWG\%Q^'^W(XW[:U&KT/M<*,U,N&-[44:+*CWCP[.LFZV6,J<4@2
