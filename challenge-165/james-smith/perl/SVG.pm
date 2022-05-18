package SVG;
use warnings;
use feature qw(say);
use Data::Dumper qw(Dumper);
use Const::Fast qw(const);

const my $DEFAULT_CONFIG => { 'margin' => 40, 'max_w' => 960, 'max_h' => 540,
                       'color' => '#000',  'stroke' => 3,
                       'fill' => '#ccc',   'radius' => 10,
                       'border' => '#000', 'bg' => '#eee' };
const my $LINE_TEMPLATE  => '<line x1="%s" y1="%s" x2="%s" y2="%s" />';
const my $POINT_TEMPLATE => '<circle cx="%s" cy="%s" r="%s" />';
const my $SVG_TEMPLATE   => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
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
</svg>';


sub new {
  my ( $class, $config ) = @_;
  my $self = {
    'config' => { %{$DEFAULT_CONFIG}, %{$config} },
    'points' => [],
    'lines'  => [],
    'min_x'  => undef,
    'max_x'  => undef,
    'min_y'  => undef,
    'max_y'  => undef,
    'width'  => undef,
    'height'  => undef,
    'scale'  => undef,
  };
  bless $self, $class;
  $self;
}

sub load_data {
  my( $self, $fn, @t ) = @_;
  local $/ = undef;
  open my $ifh, '<', $fn;
    4 == (@t = split /,/) ? ( push @{$self->{'lines'}},  [@t] )       ## Length 4 - line
  : 2 == @t               ? ( push @{$self->{'points'}}, [@t] )       ## Length 2 - point
  :                         ( warn "input error: $_" )                ## o/w error
    for grep { /\S/ } split /\s+/, <$ifh>;
  close $ifh;
  $self;
}

sub add_points {
  my( $self, @points ) = @_;
  push @{$self->{'points'}}, @points;
  $self;
}

sub add_lines {
  my( $self, @lines ) = @_;
  push @{$self->{'lines'}}, @lines;
  $self;
}

sub get_range {
  my $self = shift;

  ## rather than having a special cast as the first part of the loop, we start with the
  ## values for the first point (or start of line if no points)
  my( $min_x,$min_y ) = my( $max_x,$max_y ) = @{$self->{'points'}} ? @{$self->{'points'}[1]} : @{$self->{'lines'}[0]};

  ## Compute the range of all points. We comma separate conditions so we only need one postfix for
  ## We use ($c)&&($a=?) to mimic if($c) { $a=? } so we can use the postfix loop...
  ## Note we unravel the two ends of the line by mapping the each line ($_) to $_ + the last two values $_.
  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1])
    for @{$self->{'points'}}, map {($_,[$_->[2],$_->[3]])} @{$self->{'lines'}||[]};
  ( $self->{'min_x'}, $self->{'max_x'}, $self->{'min_y'}, $self->{'max_y'} ) = ( $min_x, $max_x, $min_y, $max_y );
  $self;
}

sub best_fit {
  my $self = shift;
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = @{$self->{'points'}};
  $sx += $_->[0], $sxy += $_->[0]*$_->[1], $sy += $_->[1], $sxx += $_->[0]*$_->[0] for @{$self->{'points'}};
  return $sx/$n unless $n*$sxx - $sx*$sx;
  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  ( ($sy-$b*$sx)/$n, $b );
}

sub add_line_of_best_fit {
  my $self = shift;
  my ($a,$b) = $self->best_fit;
  my ($min_x, $max_x, $min_y, $max_y, $extn) = ( $self->{'min_x'}, $self->{'max_x'}, $self->{'min_y'}, $self->{'max_y'}, $self->{'config'}{'margin'} );
  ## special case of a vertical line
  $self->add_lines( [ $a, $min_y - $extn, $a, $max_y + $extn] ), return $self unless defined $b;

  ## Normal case - get y coprdinates of end points, adjust if outside the box...
  my $l_y = $a + $b * ($min_x - $extn);
  my $r_y = $a + $b * ($max_x + $extn);
  my $l_x = $l_y < $min_y - $extn ? ( ( $l_y = $min_y - $extn ) - $a)/$b
          : $l_y > $max_y + $extn ? ( ( $l_y = $max_y + $extn ) - $a)/$b : $min_x - $extn;
  my $r_x = $r_y < $min_y - $extn ? ( ( $r_y = $min_y - $extn ) - $a)/$b
          : $r_y > $max_y + $extn ? ( ( $r_y = $max_y + $extn ) - $a)/$b : $max_x + $extn;
  $self->add_lines( [ $l_x, $l_y, $r_x, $r_y ] );
}

sub calculate_image_size {
  my $self = shift;
  my $margin = $self->{'config'}{'margin'};

  ## Adjust height and width so it fits the size from the self->{'config'}ig.
  my($W,$H,$width,$height) = ($self->{'config'}{'max_w'},$self->{'config'}{'max_h'},$self->{'max_x'}-$self->{'min_x'}+2*$margin,$self->{'max_y'}-$self->{'min_y'}+2*$margin);
  ( $width/$height > $W/$H ) ? ( $H = $height/$width*$W ) : ( $W = $width/$height*$H );
  ## Calculate the scale factor so that we keep spots/lines the same size irrespective of the ranges.
  ( $self->{'width'}, $self->{'height'}, $self->{'scale'} ) = ( $W, $H, $width/$W );
  $self;
}

sub render_with_best_fit {
  my $self = shift;
  return $self->get_range()->add_line_of_best_fit()->_render();
}

sub render {
  my $self = shift;
  return $self->get_range()->_render();
}

sub _render {
  my $self = shift;
  $self->calculate_image_size();
  my $margin = $self->{'config'}{'margin'};
  sprintf $SVG_TEMPLATE,
    $self->{'height'}, $self->{'width'},  $self->{'min_x'} - $margin, $self->{'min_y'} - $margin,
                                          $self->{'max_x'} - $self->{'min_x'} + 2 * $margin,
                                          $self->{'max_y'} - $self->{'min_y'} + 2 * $margin,
    $self->{'config'}{'border'}, $self->{'scale'}, $self->{'config'}{'bg'}, $self->{'min_x'} - $margin, $self->{'min_y'} - $margin,
                                          $self->{'max_x'} - $self->{'min_x'} + 2 * $margin,
                                          $self->{'max_y'} - $self->{'min_y'} + 2 * $margin,
    $self->{'config'}{'color'}, $self->{'config'}{'stroke'} * $self->{'scale'}, join( qq(\n    ), map { sprintf $LINE_TEMPLATE,   @{$_} } @{$self->{'lines'}} ), ## lines
    $self->{'config'}{'fill'}, join( qq(\n    ), map { sprintf $POINT_TEMPLATE,  @{$_}, $self->{'config'}{'radius'}*$self->{'scale'}  } @{$self->{'points'}}   )  ## points

}

1;
