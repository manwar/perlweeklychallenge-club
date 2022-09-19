#!/usr/bin/env perl
# Perl weekly challenge 167
# Task 2: Gamma function
#
# See https://wlmb.github.io/2022/05/30/PWC167/#task-2-gamma-function
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
my $pi=4*atan2(1,1);
# coefficients for g=7, n=9, from https://mrob.com/pub/ries/lanczos-gamma.html
my $c=pdl[qw(   0.99999999999980993
              676.5203681218851
	    -1259.1392167224028
	       771.32342877765313
	      -176.61502916214059
	        12.507343278686905
	        -0.13857109526572012
	         9.9843695780195716e-6
	         1.5056327351493116e-7)];
my $g=7;
die 'Usage: ./ch-2.pl z1 [z2...] to calculate the Gamma function of z1, z2...'
     unless @ARGV;
# Notice that the arguments may be real or complex, of the form 2+3i
my $z=pdl join " ", @ARGV;
say "gamma$z=", gamma($z);

sub gamma {
    my $z = shift;
    my $gamma=$z->zeroes; # ndarray for results
    # compute separately for the cases re($z)<.5 and >=.5
    my ($small_z, $small_gamma)=where($z, $gamma, $z->re <0.5);
    my ($large_z, $large_gamma)=where($z, $gamma, $z->re >=0.5);
    gamma_aux(1-$small_z, $small_gamma);
    $small_gamma.=$pi/(sin($pi*$small_z)*$small_gamma); # reflection formula
    gamma_aux($large_z, $large_gamma);
    return $gamma;
}

sub gamma_aux {
    my ($z, $res)=@_;
    return if $z->isempty;
    my $zm1=$z-1;
    my $den=$zm1->dummy(0)+$c->sequence; # denominator den_{ki}=z_i+c_k
    $den((0)).=1; # replace den_{0i}=1
    my $a=($c/$den)->sumover; # sum_k  c_k/den_k
    # compute result and copy into results array
    $res.=sqrt(2*$pi)*($zm1+$g+1/2)**($zm1+1/2)*exp(-($zm1+$g+1/2))*$a;
}
