[< Previous 164](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-164/james-smith) |
[Next 166 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-166/james-smith)

# The Weekly Challenge 165

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-165/james-smith

# Challenge 1 - Scalable Vector Graphics (SVG) & Challenge 2 - Line of Best Fit

Usually I write up to separate pieces for our weekly challenge - but as these are linked I though I would write this as a single blog.

**NOTE we will assume:**
 * that there is at least one point or line to draw;
 * for the `ch-2.pl` there are at least two points to be drawn; {and the slope of the line is not infinite}

## Line of best fit

Although this is challenge 2, let me start by computing explaining how to compute the best fit line (using linear regression) of a set of points.

The equation for the gradient is:

```
       n * sum(xy) - sum(x) * sum(y)
   b = -----------------------------
       n * sum(xx) - sum(x) * sum(x)
```

we can then get the intercept as:

```
       s(y) - b * s(x)
   a = ---------------
              n
```

This is encaptulated in the function:

```perl
sub best_fit {
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = @{$_[0]};
  $sx += $_->[0], $sxy += $_->[0]*$_->[1],
  $sy += $_->[1], $sxx += $_->[0]*$_->[0] foreach @{$_[0]};
  return $sx/$n unless $n*$sxx - $sx*$sx;                     ## Clause works out if all the points have the same x
  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  return ( ($sy-$b*$sx)/$n, $b );
}
```

There is a special case in which `$n*$sxx - $sx*$sx` *i.e.* all points on a single vertical line - which means that the
calculation will fail. In this case we just return a single value which is this x-coordinate. And later the code
uses this to draw a vertical line.

## Parsing the input

Probably the easiest part of the process - note this is written as the short version,
the examples had two cases where there were one or more entries per line. This treats
the whole file as a single line, and splits on whitespace which avoids the need
for nested loops. ***Note** this is not ideal if the file is large - because working one line at a time is better for memory management.*

We use ternary operators to replace `if`/`elsif`/`else` structure - which again allows
us to use a single postfix `for`.

```perl
sub get_points_and_lines {
  my($ps,$ls,@t)=([],[]);
  local $/ = undef;

    4 == (@t = split /,/) ? ( push @{$ls}, [@t]      )       ## Length 4 - line
  : 2 == @t               ? ( push @{$ps}, [@t]      )       ## Length 2 - point
  :                         ( warn "input error: $_" )       ## o/w error
                                                       for grep { $_ } split /\s+/, <>;
  return ($ps,$ls);
}
```

***Gotcha:** There is a gotcha here - it is an example where `\@t` and `[@t]` are different, if you use the latter `\@t` every
element in the arrays will be the same, as they will all be the same pointer!!!*

## Computing the range of points

By breaking the code down each part is *relatively* simple. To avoid external libraries, we do this in standard way. Loop through
points if less than min, update min etc.... By using comma-separated clauses we can use a single `for` loop, and to achieve this
we use the `(X)&(Y)` to replace `Y if X`.

```perl
sub get_ranges {
  my( $ps, $ls ) = @_;
  my( $min_x,$min_y ) = my( $max_x,$max_y ) = @{$ps} ? @{$pts->[0]} : @{$ls->[0]};
  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1]) for @{$ps}, map {($_,[$_->[2],$_->[3]])} @{$ls||[]};
  ( $min_x, $max_x, $min_y, $max_y );
}
```

## Finding the line to draw for best fit

This bit of code hides away the computation of the best fit line, and computing the start/end of the visible part.
We get the best fit line, and the range of the points.

If we have a vertical line (special case) we just draw the line from top to bottom of the points at the x-value of 
all the points.

If we don't we have a slightly more interesting challenge - on which sides do the regression lines leave the drawing area:

To do this we:
  * Compute the vertical position of the line at the left and right of the image
  * If it is above the box we have to set it to the top of the box and adjust the x location accordingly
  * If it is below the box we have to set it to the bottom of the box and adjust the x location accordingly
  * otherwise we just set the x-location to the left or right end of the image.

```perl
sub add_best_fit_line {
  my ( $ps, $ls, $extn ) = @_;
  $extn //= 40;
  my( $a, $b                         ) = best_fit(   $ps );
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $ps );
  unless( defined $b ) {
    push @{$ls}, [ $a, $min_y - $extn, $a, $max_y + $extn ];
    return;
  }
  my $l_y = $a + $b * ($min_x - $extn);
  my $r_y = $a + $b * ($max_x + $extn);
  my $l_x = $l_y < $min_y - $extn ? ( ($l_y = $min_y - $extn ) - $a)/$b
          : $l_y > $max_y + $extn ? ( ($l_y = $max_y + $extn ) - $a)/$b : $min_x - $extn;
  my $r_x = $r_y < $min_y - $extn ? ( ($r_y = $min_y - $extn ) - $a)/$b
          : $r_y > $max_y + $extn ? ( ($r_y = $max_y + $extn ) - $a)/$b : $max_x + $extn;
  push @{$ls}, [ $l_x,$l_y,$r_x,$r_y ];
}
```

**Notes:**
  * We update `$l_y` at the same time as working out the new value of `$l_x` etc...
  * This is our first use of `//=` we have in this code - this allows you to set the value a variable if it is undefined - `$extn//=40` -
    this is really good for default values for function calls (either with assignment `$a//=$b` or just simply `$a//$b`.

## Rendering the SVG

There are three parts to the SVG render.

 * Working out what range to draw;
 * Working out the dimensions of the point space and image (and any related scaling);
 * Rendering the points.

The first part we have already solved above - again we create a margin round the points - so we don't lose the edge of points.

The second part we can get the apsect ratio of our image from the range above. But then we need to find an image that fits our bounding box.

If the aspect ratio of our image is taller than the aspect ratio of the points we want to draw, then we have to reduce the image vertically.

   `img_width = DEFAULT_WIDTH; img_height = height/width * DEFAULT_WIDTH`

otherwise we need to make it narrower.

   `img_width = width/height * DEFAULT_HEIGHT; img_height = DEFAULT_HEIGHT`

Once we have worked out the height/width of the image and the plot space we can work out what the scale-factor is. We can use this to choose the
radius/thicknes of lines/dots etc to keep them the same size irrespective of the dimensions.

Scale factors is given by `width/img_width`

Finally we get to the renderering which gives us the `sprintf` from hell... saying that `sprintf` is one of the most useful parts of perl!

```perl
sub render_svg {
  my( $ps, $ls, $config          ) = @_;
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $pts, $0 eq 'ch-2.pl' ? [] : $lines );
  my $margin = $config->{'margin'}//20;

  ## Adjust height and width so it fits the size from the config.
  my($W,$H,$width,$height) = ($config->{'max_w'}//800,$config->{'max_h'}//600,$max_x-$min_x+2*$margin,$max_y-$min_y+2*$margin);
  ( $width/$height > $W/$H ) ? ( $H = $height/$width*$W ) : ( $W = $width/$height*$H );
  ## Calculate the scale factor so that we keep spots/lines the same size irrespective of the ranges.
  my $sf = $width/$W;

  sprintf '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="%s" width="%s" viewBox="%s %s %s %s" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  <rect stroke="%s" stroke-width="%s" fill="%s" x="%s" y="%s" width="%s" height="%s" />
  <g stroke="%s" stroke-width="%s">
    %s
  </g>
  <g fill="%s">
    %s
  </g>
</svg>',
    $H, $W, $min_x - $margin, $min_y - $margin, $width, $height,                   ## svg element
    $config->{'border'}//'#000', $sf, $config->{'bg'}//'#eee',                     ## background rectangle
      $min_x - $margin, $min_y - $margin, $width, $height,
    $config->{'fill'}//'#000', ($config->{'stroke'}//5) * $sf,                     ## lines
      join( qq(\n    ), map { sprintf '<line x1="%s" y1="%s" x2="%s" y2="%s" />', @{$_} } @{$ls} ),
    $config->{'color'}//'#ccc',                                                    ## dots
      join( qq(\n    ), map { sprintf '<circle cx="%s" cy="%s" r="%s" />',  @{$_}, ($config->{'radius'}//10)*$sf  } @{$ps}   )
}

```
## Using `$0`

Rather than writing two programmes this week - I have written a single program - and used `$0` the programme name two switch on/off parts of the code.

 * If we are running `ch-1.pl` we need to include the lines in the range calculation in the renderer, if we are running `ch-2.pl` we don't want to (it adds the margins a second time which we don't want)

 * If we are running `ch-2.pl` we need to compute the line of best fit, but obviously in `ch-1.pl` we don't.

So (pseudo code) we have:

```
  get_data()
  get_best_fit_and_limit_to_box() if $0 eq 'ch-2.pl';
  ## Render
  get_range( $0 eq 'ch-1.pl' ? "include lines" : "points only" );
  get_sizes_and_rescale()
  render();
```

This is a common practice amongst many system utilities where the name of the script alters the functionality. It avoids duplicating code without the need of an external library or module. Symlinks are just used to set the aliases. A common example of these are start/stop/log viewing scripts for applications.

## Altogether now - this is the full code (annotated)

```perl
#!/usr/local/bin/perl
use strict;

use warnings;
use feature qw(say);

my $CONFIG = {
  'margin' =>     40, 'max_w' =>    960, 'max_h' => 540,   ## Size of image & margins
  'stroke' =>      5, 'color' => '#900',                   ## Style for lines
  'radius' =>     10, 'fill'  => '#090',                   ## Style for dots
  'border' => '#009', 'bg'    => '#ffd',                   ## Style for "page"....
};

my ($pts,$lines) = get_points_and_lines( );                                ## Parses file to get lines/points
add_best_fit_line( $pts, $lines, $CONFIG->{'margin'} ) if $0 eq 'ch-2.pl'; ## Only if fitting line (ch-2.pl)
say render_svg(    $pts, $lines, $CONFIG );                                ## Pass in config to render

##----------------------------------------------------------------------
## Now the code does the real work....
##----------------------------------------------------------------------

## Parse stdin / files given on command line, to return a list of points and lines..

sub get_points_and_lines {
  my($ps,$ls,@t)=([],[]);
  local $/ = undef;

    4 == (@t = split /,/) ? ( push @{$ls}, [@t]      )       ## Length 4 - line
  : 2 == @t               ? ( push @{$ps}, [@t]      )       ## Length 2 - point
  :                         ( warn "input error: $_" )       ## o/w error
                                                       for grep { $_ } split /\s+/, <>;
  return ($ps,$ls);
}

## Compute the best fit line for the points array (using linear regression...
## Assumes a dependency of y on x....

sub best_fit {
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = @{$_[0]};
  $sx += $_->[0], $sxy += $_->[0]*$_->[1], $sy += $_->[1], $sxx += $_->[0]*$_->[0] foreach @{$_[0]};
  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  ( ($sy-$b*$sx)/$n, $b );
}

## Get the range of x,y values for the given list of lines/points
## Returns a tuple of min & max x and min & max y.

sub get_ranges {
  my( $ps, $ls ) = @_;
  my( $min_x,$min_y ) = my( $max_x,$max_y ) = @{$ps} ? @{$pts->[0]} : @{$ls->[0]};
  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1]) for @{$ps}, map {($_,[$_->[2],$_->[3]])} @{$ls||[]};
  ( $min_x, $max_x, $min_y, $max_y );
}

## Get the best fit line, and then add extend it to edge of the box - by default we assume that the line will start/end on
## the side of the box, but just to be sure - we check to see if the pts lie above or below the top/bottom of the box and
## move them appropriately.

sub add_best_fit_line {
  my ($ps,$ls,$extn) = @_;
  $extn //= 40;
  my( $a, $b                         ) = best_fit(   $ps );
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $ps );
  my $l_y = $a + $b * ($min_x - $extn);
  my $r_y = $a + $b * ($max_x + $extn);
  my $l_x = $l_y < $min_y - $extn ? ( ($l_y = $min_y - $extn ) - $a)/$b
          : $l_y > $max_y + $extn ? ( ($l_y = $max_y + $extn ) - $a)/$b : $min_x - $extn;
  my $r_x = $r_y < $min_y - $extn ? ( ($r_y = $min_y - $extn ) - $a)/$b
          : $r_y > $max_y + $extn ? ( ($r_y = $max_y + $extn ) - $a)/$b : $max_x + $extn;
  push @{$ls}, [ $l_x,$l_y,$r_x,$r_y ];
}

## Finally the rendering of the points/lines, this uses most of the config entries to deal with colour, size etc.
## We get the range and again add the margin { we don't include the lines in the equation if we are doing challenge 2
## the line fitting as otherwise we would extend the region twice... }
##
## Once we have the size of the image - we work out it's aspect ratio and work out whether we have to make the image
## narrower or shorter so that the image is no-bigger than the suggested size and that the image is as big as possible
##
## As we have a scaling between the x+y values and the size of the image - we need to adjust the size of dots/width of lines
## by multiplying these all by a scale factor

sub render_svg {
  my( $ps, $ls, $config          ) = @_;
                                         ## Ignore lines if doing challenge 2 (best fit)
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $pts, $0 eq 'ch-2.pl' ? [] : $lines );
  my $margin = $config->{'margin'}//20;

  ## Adjust height and width so it fits the size from the config.
  my($W,$H,$width,$height) = ($config->{'max_w'}//800,$config->{'max_h'}//600,$max_x-$min_x+2*$margin,$max_y-$min_y+2*$margin);
  ( $width/$height > $W/$H ) ? ( $H = $height/$width*$W ) : ( $W = $width/$height*$H );
  ## Calculate the scale factor so that we keep spots/lines the same size irrespective of the ranges.
  my $sf = $width/$W;

  sprintf '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="%s" width="%s" viewBox="%s %s %s %s" xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"
  xmlns:xlink="http://www.w3.org/1999/xlink">
  <rect stroke="%s" stroke-width="%s" fill="%s" x="%s" y="%s" width="%s" height="%s" />
  <g stroke="%s" stroke-width="%s">
    %s
  </g>
  <g fill="%s">
    %s
  </g>
</svg>',
    $H, $W, $min_x - $margin, $min_y - $margin, $width, $height,                   ## svg element
    $config->{'border'}//'#000', $sf, $config->{'bg'}//'#eee',                     ## background rectangle
      $min_x - $margin, $min_y - $margin, $width, $height,
    $config->{'fill'}//'#000', ($config->{'stroke'}//5) * $sf,                     ## lines
      join( qq(\n    ), map { sprintf '<line x1="%s" y1="%s" x2="%s" y2="%s" />', @{$_} } @{$ls} ),
    $config->{'color'}//'#ccc',                                                    ## dots
      join( qq(\n    ), map { sprintf '<circle cx="%s" cy="%s" r="%s" />',  @{$_}, ($config->{'radius'}//10)*$sf  } @{$ps}   )
}
```
