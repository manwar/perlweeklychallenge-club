# Perl Weekly Challenge #076 Task 2
# Word Search
# task statement:
# Write a script that takes two file names. The first file would contain word search grid as shown below. The second file contains list of words, one word per line. You could even use local dictionary file.
#
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
    my @temp = @_;
    @temp = grep {defined($_)} @temp;
    # without the `grep {defined($_)}`, the program crashes
    #  while the input grid is a vertically longer rectangle.
    # I haven't figured out why. Aug 3rd 2020
    return lc(join "", @temp);
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
    my @ulefttolright;
    my @extra_dia;
    my $xlen_t = scalar @{$mat[0]};
    my $ylen_t = scalar @mat;
    $ulefttolright[0] = joinline map {${$mat[$_]}[$_]} (0..$ylen_t-1);
    $ulefttolright[1] = reversestring $ulefttolright[0];

    if ($xlen_t >= $ylen_t) {         
        for my $c (0..$xlen_t-$ylen_t) {
            $ulefttolright[$c*2] = joinline 
                    map {${$mat[$_]}[$c+$_]} (0..$ylen_t-1) ; 
            $ulefttolright[$c*2+1] = reversestring $ulefttolright[$c*2]; 
        }

         for my $c (0..$ylen_t-2) {
            $extra_dia[$c*4] = joinline 
                map {${$mat[$_]}[$xlen_t-$ylen_t+$c+$_]} (0..$ylen_t-$c-1) ; 
            $extra_dia[$c*4+1] = reversestring $extra_dia[$c*4];
            $extra_dia[$c*4+2] = joinline 
                    map {${$mat[$c+$_]}[$_]} (0..$ylen_t-$c-1) ; 
            $extra_dia[$c*4+3] = reversestring $extra_dia[$c*4+2];
        }
    }
    else {
        for my $c (0..$ylen_t-$xlen_t) {
            $ulefttolright[$c*2] = joinline  
                    map {${$mat[$_+$c]}[$_]} (0..$xlen_t-1) ; 
            $ulefttolright[$c*2+1] = reversestring $ulefttolright[$c*2]; 
        }
         for my $c (0..$xlen_t-2) {
              $extra_dia[$c*4] = joinline 
                  map {${$mat[$ylen_t-$xlen_t+$c+$_]}[$_]} (0..$xlen_t-$c-1) ;
             $extra_dia[$c*4+1] = reversestring $extra_dia[$c*4];
             $extra_dia[$c*4+2] = joinline
                map {${$mat[$_]}[$c+$_]} (0..$xlen_t-$c-1) ; 
             $extra_dia[$c*4+3] = reversestring $extra_dia[$c*4+2];
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
    my $xlen_t = scalar @{$mat[0]};
    my $ylen_t = scalar @mat;
    for my $i (0..$xlen_t-1) {
        @{$newmat[$i]} = ();
        for my $j (0..$ylen_t-1) {
            ${$newmat[$i]}[$j] = ${$mat[$i]}[$ylen_t-1-$j];
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
        if (not($unique{$word}) && defined($_) && $_ =~ /$word/ ) {
            print $word, " ";
            $unique{$word} = 1;
        } 
    }
}
print "\n";


# grid: as given in task statement
# words list: 
# https://www.oxfordlearnersdictionaries.com/wordlists/oxford3000-5000
# words with length more than or equal to 5 in the grid:
#   align broad constitution depart enter midst social virus
#
# Running time
# real	0m0.314s
# user	0m0.302s
# sys	0m0.012s
