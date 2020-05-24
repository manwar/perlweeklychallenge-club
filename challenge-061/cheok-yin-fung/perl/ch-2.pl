#!/usr/bin/perl
use strict;
#use Array::Compare, List::Compare;
#use Test::Simple tests => 7;

sub threesum {
    my $len = $_[0];
    my $remain = $len - $_[1] - $_[2] - $_[3];
    return (($remain >= 1) && ($remain <= 3));
}

sub possible_octet {
    my $item = $_[0];
    if ($item =~ /^[0-9]$/ or $item =~ /^[1-9][0-9]$/ ) {
        return 1; }
    elsif ($item =~ /^[1-9][0-9][0-9]$/) {
        return  ( $item <= 255) ;
    }
    else {
        return 0;
    }

}


sub myjoinsplice {
    my $word = $_[0];
    my $offset = $_[1]; 
    my $section_len = $_[2];
    my @letters = split //, $word;
    return ( join '', splice(@letters,$offset,$section_len) ) ;
}


sub ipv4 {
    my @answers = ();
    my $iplength = length $_[0];
    my $ip = $_[0];
    for my $i (1..3) {
       for my $j (1..3) {
          for my $k (1..3) {
              if (threesum($iplength,$i,$j,$k) ) {
                   my $a = myjoinsplice($ip,0,$i);
                   my $b = myjoinsplice($ip,$i,$j);
                   my $c = myjoinsplice($ip,$i+$j,$k);
                   my $d = myjoinsplice($ip,$i+$j+$k, $iplength-$i-$j-$k);
                   if (possible_octet($a) and possible_octet($b)
                      and possible_octet($c) and possible_octet($d)) {
                        push @answers, (join '.' , $a,$b,$c,$d);
                        #print "$a $b $c $d","\n";
                        #                   print join '.', $a,$b,$c,$d; print "\n";
                    }
               }     
          } 
        }
    }
    # print join "  " , @answers; print "\n";
    return \@answers;
}


print join "\n", @{ipv4("$ARGV[0]")};
