# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o
 */

int main (void) {
    char fst = '"' + 1;

    /* Pi, base-60, encoded. '\' is escaped. */
    char * pi =
        "$T2/ZF.CU[H=&:\\X*^)?$KCV+Z@7<-*@+\\@'*H$J@;#SA3Y^.(OG7<':]P.6"
        "-DVB4B'02VUR$/;J?2)A4L^C)XC'?S).0\\8M-S[=,X-\\@DP^+4:J5,*&UN[G"
        "(LNP32+DU2*L&JN-0N'W.;/P&@2II.(W0FOW'>#*[U(UDI?%$N7OIQ#60<YD"
        ",6(LL)#SNX#4)3JI%#/9Z<M7.RKT#G-+^Q/K#+ODLP)3M''/$QS(2V/)?A$E"
        "'2'4AG*;;QJ0$.*WCX-C.PW^&^FCZS#\\>6[J+'-NC2%<A7/'.>KD,L-KB>?C"
        "/IQ2[%(K#Q0U.&ON.E+0>B5\\%>+S3I*U1KH\\#LG9C[&Q/^W&-X854=,VQA5W"
        "##=5*V(T28+%-#P12M,OMV+.,?.4./$X572$%XEAI8(^-O%4$8'QOJ+VU+*2"
        "(;0L#.%O3E^7.)LFG8*LB@M\\)+,:WK)K108X)<S+UH&TR3(V#Q(8?S%'.^\\J"
        ")>L:-Z'>KE-=(?)20P'5'J-F&9)=I$,*Z#(0-'UB8=*D7GL:-?1NSH,VP5LN"
        "*LGZ2'&LWN$0$@?7RN.7TMOF/&:L%]%:7U+W%/*-$)$K6;JR+A*:5@%Q^>0,"
        "'X[LF7$9/S4N&F->G$)VXSD3-F&1^/#>17M,+W9@3%&7E6;V&/L.FW-O*OPV"
        "*-,B>9(U<@MJ)C/.?B+T>2AZ.=#X&&-AT9,))8*0*F#QG784#/XKBK/J[;=W"
        ".%5\\R2+.E40A)&=:W9/47DX,)#VQFO/,$Z9^,\\Q^$.#B0VB'*^#\\;O&6X\\?C"
        "/##QF%.DG=LO,K96%T+@=LGN-?W9IB&2AK(#'EFPDO,I<XL&.P;%<=#C[S\\^"
        "+N6R=8+-OWG\\%Q^'^W(XW[:U&KT/M<*,U,N&-[44:+*CWCP[.LFZV6,J<4@2"
        "'*SP\\@./VIQG#51T'<)<*;)]'?A'2[+.@U\\))]H$U<)JU#@4)#DP34,[4@=K"
        "-@^DX8*Y-0JW%0J5ZR,52=,'%C3X@+%'A<=0)P@L@**:%I.+(I9#7J#\\&/W0"
        "(UY>73.(B=&Z+[,1A,.V8F&'&A5'%9*5[X)6#I,T7X)#.7B=&A*Q=5*TEZJN"
        "-IVV%Q-?A0YZ'^K@CK/0C\\\\9&0W%8V,A=QY[$'YU1Q&>YT#;%BICA9%MCT\\N"
        "#W%8'9%H7N%<#G8J/4.-^M*3(H78?*)#ZQ32,ALV@T$)S@'(/S9?5;-%&X&@";
    printf ("3.");
    size_t l = strlen (pi);
    for (size_t i = 0; i < l; i += 6) {
        long number = 0;
        for (size_t j = i; j < i + 6; j ++) {
            number *= 60;
            number += pi [j] - fst;
        }
        printf ("%ld", number);
    }
    printf ("\n");
}
