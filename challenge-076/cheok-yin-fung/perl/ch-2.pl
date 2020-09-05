# Perl Weekly Challenge #076 Task 2 Word Search
# task statements:
# Write a script that takes two file names. 
# The first file would contain word search grid 
# as shown [below]. The second file contains list of words, 
# one word per line. You could even use 
# local dictionary file.
# Usage: ch-2.pl gridfile dictfile 

use strict;
use warnings;
use Data::Dumper;

my @matrix;
my @dictwords;
my $gridfile;
my $dictfile;

if ($ARGV[1]) {
    $gridfile = $ARGV[0];
    $dictfile = $ARGV[1];
} 
else {
    $gridfile = "pwc076grid";
    $dictfile = "1000engwords.txt";
}

open GRID, $gridfile or die "no such text file for the grid: $gridfile";
open DICT, $dictfile or die "no such text file for the dictionary: $dictfile";

#read words from dictionary file
foreach (<DICT>) {
    my @temp;
    if ($_ =~ /^[a-z]+$/) {
        s/\s/\r/g;
        s/\s//g;
        push @temp, $_ ;
    }
    for my $line (@temp) {
        push @dictwords, $line;
    }
}

@dictwords = sort {$a cmp $b} @dictwords;

# read the grid from grid file
my $k = 0;
for (<GRID>) {
    chomp;
    if ($_ ne "") {
        @{$matrix[$k]} = split " ", $_;
        $k++;
    }
}

my $xlen = scalar @{$matrix[0]};
my $ylen = scalar @matrix;

# some subroutines for manipulating the lines on the grid 
# ==============

sub joinline {
    return lc(join "", @_);
}

sub reversestring {
    return join "", reverse (split //, $_[0]);
}


# horizontal and vertical lines
# =============

my @rowline, my @colline, my @urighttolleft;
my @diagonal;

for my $i (0..$ylen-1) { 
    $rowline[$i*2] = joinline @{$matrix[$i]};
    $rowline[$i*2+1] = joinline reverse @{$matrix[$i]};
}

for my $j (0..$xlen-1) {
    $colline[$j*2] = joinline( map {${$matrix[$_]}[$j]} (0..$ylen-1) );
    $colline[$j*2+1] = reversestring $colline[$j*2];
}
# ===========================


# diagonal
# ==============================
sub find_diagonal {
    my @mat = @{$_[0]};
    my @ulefttolright = ();
    my @extra_dia = ();
    my $t_xlen = scalar @{$mat[0]};
    my $t_ylen = scalar @mat;
    my $t_limit = ($t_xlen > $t_ylen) ? $t_ylen : $t_xlen;
    my $t_diff = ($t_xlen > $t_ylen) ? $t_xlen - $t_ylen : $t_ylen - $t_xlen;

    if ($t_xlen >= $t_ylen) {         
        for my $c (0..$t_diff) {                          
            $ulefttolright[$c*2] = joinline                            
                    map {${$mat[$_]}[$c+$_]} (0..$t_ylen-1) ;        
            $ulefttolright[$c*2+1] = reversestring $ulefttolright[$c*2];   
        }

        for my $d (0..$t_limit-2) {                     
            $extra_dia[$d*4] = joinline 
                map {${$mat[$_]}[$t_diff+$d+1+$_]} (0..$t_limit-$d-2) ; 
            $extra_dia[$d*4+1] = reversestring $extra_dia[$d*4];
            $extra_dia[$d*4+2] = joinline 
                map {${$mat[$d+1+$_]}[$_]} (0..$t_limit-$d-2) ;
            $extra_dia[$d*4+3] = reversestring $extra_dia[$d*4+2];
        }
    }
    else {
        for my $c (0..$t_diff) {
            $ulefttolright[$c*2] = joinline  
                map {${$mat[$_+$c]}[$_]} (0..$t_xlen-1) ; 
            $ulefttolright[$c*2+1] = reversestring $ulefttolright[$c*2]; 
        }
         for my $d (0..$t_limit-2)  {        
             $extra_dia[$d*4] = joinline 
                 map {${$mat[$t_diff+$d+1+$_]}[$_]} (0..$t_limit-$d-2) ;
             $extra_dia[$d*4+1] = reversestring $extra_dia[$d*4];
             $extra_dia[$d*4+2] = joinline
                 map {${$mat[$_]}[$d+1+$_]} (0..$t_limit-$d-2) ; 
             $extra_dia[$d*4+3] = reversestring $extra_dia[$d*4+2];
        }


    }
    return (@ulefttolright, @extra_dia);
}
# =============================


# antidiagonal
# ==============================

sub vertical_reflection {
    my @mat = @{$_[0]};
    my @newmat;
    my $t_xlen = scalar @{$mat[0]};
    my $t_ylen = scalar @mat;
    for my $i (0..$t_ylen-1) {
        @{$newmat[$i]} = ();
        for my $j (0..$t_xlen-1) {
            ${$newmat[$i]}[$j] = ${$mat[$i]}[-1-$j];
        }
    }
    return @newmat;
}


@diagonal = find_diagonal(\@matrix);
my @newmatrix = vertical_reflection(\@matrix) ;
my @antidiagonal = find_diagonal( \@newmatrix);
# ===========================


# main dish:

my %unique;

for my $word (@dictwords) {
    for (@rowline,@colline,@diagonal,@antidiagonal) {
       if (defined $_) { 
        if ($_ =~ /$word/ && not($unique{$word}) ) {
            print $word, " ";
            $unique{$word} = 1;
        } 
       }
    }
}

print "\n";

# grid: as given in task statement
# word list: 
# https://www.oxfordlearnersdictionaries.com/wordlists/oxford3000-5000
# words with length more than or equal to 5 in the grid:
#   align broad constitution depart enter midst social virus
#
# Running time
# real	0m0.254s
# user	0m0.249s
# sys	0m0.004s

