#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Your task is to accept a series of points and lines in the following format, one per line, in arbitrary order:
Point: x,y
Line: x1,y1,x2,y2
Then, generate an SVG file plotting all points, and all lines. If done correctly, you can view the output .svg file in your browser.
=cut








use FindBin qw($Bin);
use lib $Bin;
use my_svg;

my (@points, @lines);

my $input_file = 'input.txt';

{
     open my $in, "<", "$Bin/$input_file" or die "$!";

     while ( my $line = <$in> )
     {
          chomp $line;
          $line =~ tr/ //ds;
          next unless length($line);

          my @arr = split(/,/, $line);
          my %h;



          if ( 2 == @arr )
          {
               @h{qw(x y)} = @arr; 
               push @points, \%h ;
          }
          elsif ( 4 == @arr )
          {
               @h{qw(x1 y1 x2 y2)} = @arr; 

               push @lines, \%h;
          }

          if ( 2 != @arr and 4 != @arr )
          {
               warn "Confusing line: <<$line>> ... ignoring ... $/";
          }
     }

}

my $output_svg = create_svg(\@points, \@lines);

open my $out, ">", "$Bin/output_task1.svg" or die "$!";

print {$out} $output_svg;