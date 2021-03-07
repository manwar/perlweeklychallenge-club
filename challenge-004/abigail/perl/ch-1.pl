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

################################################################################
#
# We have encoded the digits of perl. We're grouping the digits (after
# the decimal dot), in groups of 9, considering this as a base-10 number,
# and then we turn this into a base-91 number. To represent the base-91
# number, we are using ASCII characters, starting from "#", up to "~",
# *BUT* skipping "\".
#
# We can encode a 9 digit base-10 number with 5 characters in base-91,
# giving us a 44.44% reduction in size.
#
################################################################################

my $first_ord  = 1 + ord ('"');
my $skip_ord   = ord ("\\");
my $last_ord   = ord ("~");
my $range      = $last_ord - $first_ord;
my $in_size    = 5;
my $out_size   = 9;

print "3.";
while (<DATA>) {
    my $pat = ".{$in_size}";
    foreach (/$pat/g) {
        my $out = 0;
        foreach (/./g) {
            $out *= $range;
            my $n = ord ();
               $n -- if $n >= $skip_ord;
            $out += $n - $first_ord;
        }
        printf "%0${out_size}d" => $out;
    }
}
print "\n";

#
# FODDER FODDER FODDER FODDER FODDER FODDER FODDER
# FODDER FODDER FODDER FODDER FODDER FODDER FODDER
#

__DATA__
%(uP7+Y`ME)gy(7')v?;%s^qc(Mj1}16idp'ONGs'2m.o,1HLY'}~P61@@Y-
*O/.v,Jc~D+ttA'&EPjR(zXxD$dr,M$P=-f*YQqe,GIZ`0x5oL1(mpl17en`
)Q$ge,L6_5.I;hj%yy6n,L_t')dtyy)[ugS&-3(c&lC:a&~8SP#+iis+WR&8
*Y;V3/+JD@-J>7u0$Nh<#2&:@+#=`/*YtP-0t8uf+tf/V&yjx>+]S=&%d}7z
0YXa9$SOyt$*mzv1&X(W(.{0G-Vya`0a}KI0pQD2,nV0:,WE0+#?F[>(iMb}
%k(tB/UO0m.8R'x%Vys_-|IgL.y-n6(v[*#+<w,K&ph2o.LfLw.'YJB%SI/r
-RGB[0/yKw);ml1+SlKv.UDG6&jY3_#=Nry$t6Ng/YXEe%A)of.>/-J1#[`]
&*M<M1Uqt]#f=#g-a$q{$Gn<,#CLb7((C*0,D]yd&c4OS#Ql2h%gd7>#'1wg
-}+B}*jWDi)/2&k,h|/)+eu-3)9{mU-`:]M/YF$a.O0SF0{~2C.EjkZ&>|lD
#%UmL+w)$V&14Ty0arq+%xnAo/XX/y0_=Bl/)f*}'Gc88'GV;X1RG~<+gJ8p
&^E~A'/3N=*R2|j&SgD@-0St?*jL@'-ZsbD$+_hy.#HkF0cO_[#t0wL-8._r
#0)@p#4(ha+lyD6,[|1w%_K//+c2#j.4xl2)SpX=.>)gp$R)ZP,IS%@,}%#J
*1zj[,sIw#%6pwl%D'fk#Bx6'%4?.0&c9'?#R7P|&ZJ;M&q6q&&|h9?0LVI}
(2lq>#/G+<,Bv`l+U'K?'2i}q+,J8W/7dU++X(l51R>#T&)fV0'I%FC%HHkt
%{(NN&Kn$]*<Aur/2kmb+:Wu&)7%WR/W[BH)+.]`/~B$S.WE~n,J_v]%-h'|
%RrIs.:wg4)KQ#G*~I)7%=m]x$z.?F/F:I#*]Lg2(h&,J*}tu6/WWEX+>e0,
$K`U.%bSL*&dG^f,lN@.+jGbU.g8,s&FwUP$9p3S/)f(4,y><Y0vnKH(:}m~
#y7eZ%~4^<1C|Ju$sQ)x0ko[G1)z8e&)U,+'N'y9,)LJT0k+B7-H5gh0z,~X
0E:/(.0dlN1&/Rn/[|SL1RLl=)|BoK$K~@E$0j%D)oW$^+bQyn.~]>{*/L)t
-Oi$Y*&I1x1Kyk#$}~i|)^4uG%|&sU)XNR-,PLl/.lmT'&_~it-16U9-B~A[
(}s.a0~]Zj*<*~%-~N27%$O,*/a,,c%<#@60On3z0~3@B13UOG/A^&K,GRHi
,S_:*&9I{_$nCM9&U^*9)WmPj+$TL8.]WpP)CWDR$u#7])K/Bi+,[B9(0~a&
&=aag,L-UG#HoAx/=@p,&ux{:0($3X*[J<4,eh{E1F&tE$cGo.&C}15*:u{Z
,:*H^'f,=~$,z%B)WZbL$DjA;/oFKa%.>ig/^o.90e/P=*Auex0TD}p/hncA
/%d87#/u19,r&sM(A+4V0%4u$.}F+P0o|4e.g(<[#5y<J++`sn,C6]p-t;&]
*wEcH.YA#C.|Tl$(2g>y*]3@5%II741/XZ>)Lm6e0``3L%.JF[+Z?8b(tj7C
'S/z}#vS|i)S9[=*/nCG)PMaY-{pML);vN?%kRcr#*.Tg,x;42'(1w.0dA)S
)-us%.#1$R-rkwf%m%B-(ctK8+4Sn^%*C1Y-wqsr%eNg11%$De&&07q+%1>-
+mCl2%)V#w%#y:[,?t*D$64`9.U+{`-SBX-+gi/o)0B$q#V$tW+#lmM)';EH
%yFPZ/Gy(~,dl@h)A&ju-Co2,-du++)[Awk&wE}p*H;._.[]4W+Eb7K#iiKB
