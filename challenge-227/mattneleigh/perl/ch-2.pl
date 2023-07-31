#!/usr/bin/perl

use strict;
use warnings;
use English;

use List::Util qw(max);

################################################################################
# PROCESSUS PRINCIPALIS INCIPIT
################################################################################

my @EXPRESSIONES = (
    "IV + V",
    "M - I",
    "X / II",
    "XI * V",
    "VII ** III",
    "V - V",
    "V / II",
    "MMM + M",
    "V - X",

    # NOTITIAE INVALIDAE
    # "Q + N",
    # "X ++ V"
);

# FORMA TEXTUM LONGITUDINEM MAXIMAM EXPRESSIONUM CONTINET
my $FORMA_TEXTUM =
        "%-"
        .
        max(map(length($_), @EXPRESSIONES))
        .
        "s => %s\n";

print("\n");
foreach my $EXPRESSIO (@EXPRESSIONES){
    printf(
        $FORMA_TEXTUM,
        $EXPRESSIO,
        EXPRESSIO_PROVISUM_CALCULAT($EXPRESSIO)
    );
}
print("\n");

exit(0);
################################################################################
# PROCESSUS PRINCIPALIS TERMINAT
# PROCESSI SUBORDINATI SEQUUNTUR
################################################################################



################################################################################
# CALCULUM FACERE CUM DUOBUS NUMERIS ET OPERANDO DETERMINATO UT PATET IN TEXTUS
# TEXTUS FORMAM SUMERE DEBET: "NUMERUS OPERATOR NUMERUS" (EXEMPLI GRATIA
# "XVI + IV" )
# UNUM ARGUMENTUM ACCIPIT:
# * TEXTUS QUI EXPRESSIONEM MATHEMATICAM CONTINET
# REDIT SI BENE GESTA:
# * NUMERUS COMPUTATUS PER MODUM PETITUM
# REDIT SI ERRORIS:
# * NUNTIUM QUI ERROREM DESCRIBIT
################################################################################
sub EXPRESSIO_PROVISUM_CALCULAT{
    my @NOTITIAE_RECEPTAE = split(" ", shift());

    # COMPUTAMOS
    my $PROVENTUS = eval(
        AD_INTEGRUM_NUMERUM_ROMANUM_CONVERTERE($NOTITIAE_RECEPTAE[0])
        .
        $NOTITIAE_RECEPTAE[1]
        .
        AD_INTEGRUM_NUMERUM_ROMANUM_CONVERTERE($NOTITIAE_RECEPTAE[2])
    );

    # PROVENTUM HIC VERIFICAMUS
    return("NON POTEST: NOTITIAE RECEPTAE INVALIDAE")
        unless(defined($PROVENTUS));
    if($PROVENTUS == 0){
        return("NULLA");
    } elsif(int($PROVENTUS) != $PROVENTUS){
        return("NON POTEST: VALOR FRACTIONEM CONTINET");
    } elsif($PROVENTUS > 3999){
        return("NON POTEST: VALOR SUPRA MMMXCIX EST");
    } elsif($PROVENTUS < 0){
        return("NON POTEST: VALOR INFRA NULLUS EST");
    }

    return(AD_NUMERUM_ROMANUM_INTEGRUM_CONVERTERE($PROVENTUS));

}



################################################################################
# AD INTEGRUM NUMERUM ROMANUM CONVERTERE
# UNUM ARGUMENTUM ACCIPIT:
# * TEXTUS QUI NUMERUM ROMANUM CONTINET
# REDIT SI BENE GESTA:
# * NUMERUS INTEGRIS
# REDIT SI ERRORIS:
# * VALORUS INDEFINITUS
################################################################################
sub AD_INTEGRUM_NUMERUM_ROMANUM_CONVERTERE{
    my @LITTERAE_NUMERALES_ROMANI = split('', uc(shift()));

    my %VALORES_NUMERALES = (
        I => 1, V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000
    );
    my $TOTALIS = 0;

    # SINGULAS LITTERAS EXAMINAMUS
    foreach my $INSTANTIA (0 .. $#LITTERAE_NUMERALES_ROMANI){
        # NUMERUM CUIUSQUE LITTERAE DETERMINARE
        my $PRAESENTEM_VALOREM =
            $VALORES_NUMERALES{$LITTERAE_NUMERALES_ROMANI[$INSTANTIA]};

        # CERTUM ESSE OPORTET NUMERUM VALIDUM ESSE
        return(undef)
            unless(defined($PRAESENTEM_VALOREM));

        if(
            ($INSTANTIA < $#LITTERAE_NUMERALES_ROMANI)
            &&
            (
                $PRAESENTEM_VALOREM
                <
                $VALORES_NUMERALES{$LITTERAE_NUMERALES_ROMANI[$INSTANTIA + 1]}
            )
        ){
            # PROXIMUS PRETII MAJOR MINUERE PRAESENTIS
            # PRETII EST
            # NUNC VALOREM SUBTRAHE
            $TOTALIS -= $PRAESENTEM_VALOREM;
        } else{
            # PRAESENTEM VALOREM ADDERE
            $TOTALIS += $PRAESENTEM_VALOREM;
        }
    }    

    return($TOTALIS);

}



################################################################################
# AD NUMERUM ROMANUM INTEGRUM CONVERTERE UTENDI METHODO TURPITER FURATA EX
# https://medium.com/@tomas.langkaas/eight-algorithms-for-roman-numerals-b06c83db12dd
# UNUM ARGUMENTUM ACCIPIT:
# * NUMERUS INTEGRIS
# REDIT SI BENE GESTA:
# * TEXTUS QUI NUMERUM ROMANUM CONTINET
# REDIT SI ERRORIS:
# * VALORUS INDEFINITUS
################################################################################
sub AD_NUMERUM_ROMANUM_INTEGRUM_CONVERTERE{
    use POSIX;

    my $INTEGRUM = int(shift());

    return(undef)
        if(($INTEGRUM < 1) || ($INTEGRUM > 3999));

    # TEXTA BREVIA VALORUM NUMERORUM COMPOSITORUM
    my @UNI = (
        "", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"
    );
    my @DECEM = (
        "", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"
    );
    my @CENTUM = (
        "", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"
    );
    my @MILLIA = (
        "", "M", "MM", "MMM"
    );

    # SIMPLEX RATIO UTENS TEXTUM E TABULIS
    return(
        $MILLIA[floor($INTEGRUM / 1000)]
        .
        $CENTUM[floor(($INTEGRUM % 1000) / 100)]
        .
        $DECEM[floor(($INTEGRUM % 100) / 10)]
        .
        $UNI[$INTEGRUM % 10]
    );

}



