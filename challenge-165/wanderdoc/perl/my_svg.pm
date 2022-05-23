#!perl
use strict;
use warnings FATAL => qw(all);

use XML::Writer;


my $MIN_X = my $MIN_Y = 1e6;
my $MAX_X = my $MAX_Y = 0;









sub create_svg
{
     my @these_points = @{$_[0]};
     my @these_lines = @{$_[1]};
     _calculate_sizes(@_[0,1]);



     my $color_point = '#0000CD';
     my $color_line  = '#CD0000';
     my $color_background = '#E5E5E5';
     my $font = 'bold 20px sans-serif';
     my $size_point = 3;
     my $size_line = 3;

     my ($buffer_x, $buffer_y) = (0, 0);

     my $slope = $_[2];
     my $intercept = $_[3];


     if ( $MIN_X < 0 ) { $buffer_x = abs($MIN_X); }
     if ( $MIN_Y < 0 ) { $buffer_y = abs($MIN_Y); }
     my $buffer_aesthetic = 10;
     my $width  = $MAX_X + $buffer_x + $buffer_aesthetic; # print $width, $/;
     my $height = $MAX_Y + $buffer_y + $buffer_aesthetic; # print $height, $/;
     
     my $writer = XML::Writer->new( OUTPUT => 'self');
     $writer->xmlDecl("UTF-8");


     $writer->doctype('svg', 
          "-//W3C//DTD SVG 1.0//EN", 
          "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd");

     $writer->startTag('svg', height => $height, width => $width, 
               xmlns => 'http://www.w3.org/2000/svg', 
               'xmlns:svg' => 'http://www.w3.org/2000/svg', 
               'xmlns:xlink' => 'http://www.w3.org/1999/xlink');



     $writer->emptyTag('rect', width => "100%",, height => "100%", 
                    fill => ${color_background});
                    
     if ( scalar @these_points )
     {
          $writer->startTag('g', 'fill' => $color_point, 'id' => "points");

          for my $point ( @these_points )
          {
               $writer->emptyTag('circle', cx => $point->{x} + $buffer_x, 
                    cy => _converse_y($point->{y} + $buffer_y, $height), r => $size_point);
          }

          $writer->endTag('g');
     }

     if ( scalar @these_lines )
     {
          $writer->startTag('g', id => "lines", 'stroke' => $color_line, 'stroke-width' => $size_line);
          for my $line ( @these_lines )
          {
               $writer->emptyTag('line', x1 => $line->{x1} + $buffer_x,  x2 => $line->{x2} + $buffer_x,
                         y1 => _converse_y($line->{y1} + $buffer_y, $height),  
                         y2 => _converse_y($line->{y2} + $buffer_y, $height));

          }
          $writer->endTag('g');
     }

     if ( $slope and $intercept )
     {
          $_ = sprintf("%.5f", $_) for ($slope, $intercept); # $slope = sprintf("%.5f", $slope);
          my $regression = "y = $slope * x + $intercept";

          $writer->startTag('text', x => $buffer_aesthetic, y => _converse_y($buffer_aesthetic, $height),
                    fill => $color_line, style=> "font: ${font};");
          $writer->characters($regression);
          $writer->endTag('text');
     }

     $writer->endTag('svg');
     $writer->end();


     return $writer->to_string;
}


sub _calculate_sizes
{
     my @these_points = @{$_[0]};
     my @these_lines = @{$_[1]};

     _change_min_max($_->{x}, $_->{y}) for @these_points;
     _change_min_max($_->{x1}, $_->{y1}) for @these_lines;
     _change_min_max($_->{x2}, $_->{y2}) for @these_lines;
}

sub _change_min_max
{

     my ( $x, $y ) = @_;
     if ( $x < $MIN_X ) { $MIN_X = $x; }
     if ( $x > $MAX_X ) { $MAX_X = $x; } 
     if ( $y < $MIN_Y ) { $MIN_Y = $y; }
     if ( $y > $MAX_Y ) { $MAX_Y = $y; }
}

sub _converse_y
{
     my ($this_y, $height) = @_;
     return $height - $this_y;
}

1;