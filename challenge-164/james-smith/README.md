[< Previous 163](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-163/james-smith) |
[Next 165 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-165/james-smith)
# The Weekly Challenge 164

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-164/james-smith

# Challenge 1 - Scalable Vector Graphics (SVG) & Challenge 2 - Line of Best Fit

Usually I write up to separate pieces for our weekly challenge - but as these are linked I though I would write this as a single blog.

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
  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  return ( ($sy-$b*$sx)/$n, $b );
}
```

## SVG

There are two parts to the SVG render.

 * Working out what range of points to draw;
 * rendering the points

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
  
## Altogether now:

```perl
get_points_and_lines( 20 );
add_best_fit_line() if $0 eq 'ch-2.pl';
say render_svg( \@pts, \@lines, {
  'max_w' => 960, 'max_h' => 540,
  'margin' => 10, 'radius' => 10, 'fill' => '#090', 'stroke' => 5, 'color' => '#900'
} );

sub best_fit {
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = @{$_[0]};
  $sx += $_->[0], $sxy += $_->[0]*$_->[1], $sy += $_->[1], $sxx += $_->[0]*$_->[0] foreach @{$_[0]};
  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  ( ($sy-$b*$sx)/$n, $b );
}

sub get_points_and_lines {
  my @t;
  while(<>) {
    chomp;
    4 == (@t = split /,/) ? ( push @lines, [@t] ) : ( push @pts, [@t] ) for split;
  }
}

sub add_best_fit_line {
  my $extn = shift;
  my( $a, $b                         ) = best_fit(   \@pts );
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( \@pts );
  my $l_y = $a + $b * ($min_x - $extn);
  my $r_y = $a + $b * ($max_x + $extn);
  my $l_x = $l_y < $min_y - $extn ? ( ($l_y = $min_y - $extn ) - $a)/$b
          : $l_y > $max_y + $extn ? ( ($l_y = $max_y + $extn ) - $a)/$b : $min_x - $extn;
  my $r_x = $r_y < $min_y - $extn ? ( ($r_y = $min_y - $extn ) - $a)/$b
          : $r_y > $max_y + $extn ? ( ($r_y = $max_y + $extn ) - $a)/$b : $max_x + $extn;
  push @lines, [ $l_x,$l_y,$r_x,$r_y ];
}

sub get_ranges {
  my( $pts, $lines ) = @_;
  my $min_x = my $max_x = @{$pts} ? $pts->[0][0] : $lines->[0][0];
  my $min_y = my $max_y = @{$pts} ? $pts->[0][1] : $lines->[0][1];
  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1]) for @{$pts}, map {($_,$_->[2],$_->[3]])} @{$lines};
  ( $min_x, $max_x, $min_y, $max_y );
}

sub render_svg {
  my( $pts, $lines, $config          ) = @_;
  my( $min_x, $max_x, $min_y, $max_y ) = get_ranges( $pts, $0 eq 'ch-2.pl' ? [] : $lines );
  my $margin = $config->{'margin'}//20;
  my($W,$H,$width,$height) = ($config->{'max_w'}//800,$config->{'max_h'}//600,$max_x-$min_x+2*$margin,$max_y-$min_y+2*$margin);
  ( $width/$height > $W/$H ) ? ( $H = $height/$width*$W ) : ( $W = $width/$height*$H );
  my $sf = $width/$W;
  return sprintf '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
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
</svg>', $H, $W, $min_x - $margin, $min_y - $margin, $width, $height,
         $config->{'border'}//'#000', $sf, $min_x - $margin, $min_y - $margin, $width, $height,
         $config->{'fill'}//'#000', ($config->{'stroke'}//5) * $sf, $config->{'bg'}//'#eee',
         join( qq(\n    ), map { sprintf '<line x1="%s" y1="%s" x2="%s" y2="%s" />', @{$_}                                 } @{$lines} ),
         $config->{'color'}//'#ccc',
         join( qq(\n    ), map { sprintf '<circle cx="%s" cy="%s" r="%s" />',        @{$_}, ($config->{'radius'}//10)*$sf  } @{$pts}   );
}
```
