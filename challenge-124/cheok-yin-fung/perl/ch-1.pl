#!/usr/bin/perl
# The Weekly Challenge 124
# Task 1 Happy International Women's Day
# Usage: $ ch-1.pl height width
use strict;
use warnings;

die "Enter height(2-15 and width(1-15) as command-line parameters\n"
     if !$ARGV[0] || !$ARGV[1];

print_venus($ARGV[0], $ARGV[1]);

# BEGIN OF SUBROUTINE PRINT_VENUS
sub print_venus {


my $height = $_[0];
my $width = $_[1];

die "The height or width is too large. Not supported.\n" 
    if $height >= 16 || $width >= 16;

die "Not supported.\n" 
    if ( $height >= 5 && $width <= 3);

die "Not supported.\n" 
    if ( $height >= 8 && $width == 4);

die "The height is too small. Not supported.\n" 
    if $height <= 1;

die "The height:width ratio is too small. Not supported.\n" 
    if    ( $height+1 < $width && $width > 4); 

die "The height:width ratio is too large. Not supported.\n" 
    if ($height > $width*1.5 && $width >= 4 );

$width-- if $width % 2 == 0;
my $is_ant_size_upper = undef;
my $is_small_upper = undef;
my $is_tiny_upper = undef;


if ($height >= 6 && $width > 4) {
    large_upper($height, $width);
} 
elsif ($height > 4 || ($height <= 4 && $width == 4)) {
    small_upper($height, $width);
    $is_ant_size_upper = 1;
    $is_small_upper = 1;
} 
else {
    tiny_upper($height, $width);
    $is_ant_size_upper = 1;
    $is_tiny_upper = 1;
}

if ($height >= 4 && !$is_tiny_upper) {
    large_lower($height, $width, $is_ant_size_upper);
} 
else {
    small_lower($height, $width);
}


}  # END OF SUBROUTINE PRINT_VENUS


# ==================================================
# ========== SUPPORTIVE SUBROUTINES ================
# ==================================================
 
sub tiny_upper {
    my $height = $_[0];
    my $width = $_[1];
    print " " x (($width-1)/2), "O", "\n";
}

sub small_upper {
    my $height = $_[0];
    my $width = $_[1];
    print " /*\\", "\n";
    print " \\_/", "\n";
}

sub large_upper {
    my $height = $_[0];
    my $width = $_[1];
    print " " x 2, "*" x ($width-4) , "\n";

    for (1..$height/2 - 2) {
        print "*", " " x ($width-2), "*", "\n";
    }
    print " " x 2, "*" x ($width-4) , "\n";
}

sub large_lower {
    my $height = $_[0];
    my $width = $_[1];
    my $is_ant_size_upper = $_[2];
    for (1..($height/4+0.5)) {
        print " " if $is_ant_size_upper && !($height == 5 && $width == 5) ;
        print " " x ($width/2) , "|", "\n";
    }
    print " " if $is_ant_size_upper && !($height == 5 && $width == 5);
    my $mid = $is_ant_size_upper ? "+" : "*";
    print "*" x (($width-1)/2), $mid, "*" x (($width-1)/2), "\n";
    for (1..($height/4+0.5)) {
        print " " if $is_ant_size_upper && !($height == 5 && $width == 5) ;
        print " " x ($width/2) , "|", "\n";
    }
}

sub small_lower {
    my $height = $_[0];
    my $width = $_[1];
    print " " x ($width/2) , "+", "\n";
}



=pod Some Examples
O
+
Parameters:
  height: 2; width: 1.


 /*\
 \_/
  |
**+**
  |
Parameters:
  height: 5; width: 5.


  ***
*     *
*     *
  ***
   |
   |
*******
   |
   |

Parameters:
  height: 8; width: 8 .


  *****
*       *
*       *
  *****
    |
    |
*********
    |
    |

Parameters:
  height: 9; width: 10.

=pod Supported Parameters
  Height allowable_width
     2         [1-4]
     3         [1-4]
     4         [1-5]
     5         [4-6]
     6         [4-7]
     7         [5-8]
     8         [6-9]
     9         [6-10]
    10         [7-11]
    11         [8-12]
    12         [8-13]
    13         [9-14]
    14        [10-15]
    15        [10-15]
     
