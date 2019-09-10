# Create script to implement Chaocipher. Please checkout wiki page for more information
# Visualizing it using rotating disk is a bit difficult, here's a video illustration of the algo
# https://www.youtube.com/watch?v=0tL9A69olRc , that helped me understand it

use strict;
use warnings;
use 5.010;

#It should be okay to modify the zenith/nadir (0 to $wheelsize)
use constant ZENITH  => 0;
use constant NADIR   => 13;

#Initialize  wheels (chaocipher with bigger wheels!)
my @pt = "7bqkj9l2hOWyzA8SLPEtRvBwUQVmxa45g ufspeTF1KHd0DrGMCZoJXi3YIN6nc"=~/./g;
my @ct = "vEDclCHZYeWo9drb6Jnkf5MRXOt UgN4Fi231GzQIx7sPaLK8TBuVpA0yjShqwm"=~/./g;

my $wheel_size = $#pt;

die "Usage:\n\tch-2.pl <-d|e> \"<string to encrypt>\"\n\n" if @ARGV<2;
my $encrypt     = $ARGV[0] eq '-e';
my $text_string = $ARGV[1];

# This function rotate the given array or a portion of the given array 
# Rotation count is defined by $r
# The whole array will be rotated by default
# but the range can be specified in $from and $to variable
sub rot {
    my ($r,$array, $from, $to) = @_;
    $r %= ($wheel_size+1);
    return if $r == 0;
    if (!(defined $to && defined $from)) {
        @{$array} = (@{$array}[$r..$#{$array}], @{$array}[0..~-$r]);
    } else {
        $r += $from;
        @{$array} = (@{$array}[0..~-$from], @{$array}[$r..$to], @{$array}[$from..~-$r],@{$array}[$to+1..$#{$array}]);
    }
}

sub cipher {
    my ($text,$enc,$ret) = @_;
    
    for my $c ($text=~/./g) {
        #find where $c is in the plain text @pt
        #grep wont stop when first occurence was found
        my $pt_pos = (grep {($enc?$pt[$_]:$ct[$_]) eq $c} 0..$wheel_size)[0];

        #Get the character from the cipher text in that position
        $ret .= $enc?$ct[$pt_pos]:$pt[$pt_pos];
        
        #rotate @pt and @ct from $pt to ZENITH
        &rot($pt_pos-ZENITH, \@pt);
        &rot($pt_pos-ZENITH, \@ct);

        #permute @ct: move the char in ZENITH + 1 to NADIR
        &rot(1,\@ct,ZENITH+1,NADIR);

        #permute @pt: rotate1 then move the char in ZENITH + 2 to NADIR
        &rot(1,\@pt);
        &rot(1,\@pt,ZENITH+2,NADIR);
    }
    return $ret;
}
say &cipher($text_string,$encrypt);
=begin
perl .\ch-2.pl -e "a quick brown fox jumps over lazy dog"
gFv4ujqOyIPdTk5I9bKrYUXY4DwkCtV27vpk9

perl .\ch-2.pl -d "gFv4ujqOyIPdTk5I9bKrYUXY4DwkCtV27vpk9"
a quick brown fox jumps over lazy dog
=cut
