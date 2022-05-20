package SVG;
use warnings;
use feature qw(say);
use Data::Dumper qw(Dumper);
use Const::Fast qw(const);

## -----------------------------------
## Constants - configuration & SVG templates...
## -----------------------------------

const my %DEFAULT_CONFIG => ( 'margin' => 40, 'max_w' => 960, 'max_h' => 540, 'color' => '#000',  'stroke' => 3,
                              'fill' => '#ccc',   'radius' => 10, 'border' => '#000', 'bg' => '#eee' );
const my $LINE_TEMPLATE  => '<line x1="%s" y1="%s" x2="%s" y2="%s" />';
const my $POINT_TEMPLATE => '<circle cx="%s" cy="%s" r="%s" />';
const my $SVG_TEMPLATE   =>
'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
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


## -----------------------------------
## Constructor
## -----------------------------------

sub new {
  my ( $class, $config ) = @_;
  my $self = {
    'config' => { %DEFAULT_CONFIG },
    'points' => [], 'lines'  => [], 'range'  => [], 'size' => [],
    'scale'  => 1,
  };
  bless $self, $class;
  $self->update_config( %{$config} )
       ->set_range( 0, 0, $self->max_w, $self->max_h )
       ->set_size(  $self->max_w, $self->max_h )
}

## -----------------------------------
## Getters....
## -----------------------------------

sub min_x   {   $_[0]{'range'}[0]       }     sub min_y   {   $_[0]{'range'}[1]       }
sub max_x   {   $_[0]{'range'}[2]       }     sub max_y   {   $_[0]{'range'}[3]       }
sub width   {   $_[0]{'size'}[0]        }     sub height  {   $_[0]{'size'}[1]        }
sub points  { @{$_[0]{'points'}}        }     sub lines   { @{$_[0]{'lines'}}         }
sub scale   {   $_[0]{'scale'}          }     sub config  {   $_[0]{'config'}{$_[1]}  }
sub margin  {   $_[0]->config('margin') }
sub max_w   {   $_[0]->config('max_w')  }     sub max_h   {   $_[0]->config('max_h')  }
sub color   {   $_[0]->config('color')  }     sub stroke  {   $_[0]->config('stroke') }
sub fill    {   $_[0]->config('fill')   }     sub radius  {   $_[0]->config('radius') }
sub border  {   $_[0]->config('border') }     sub bg      {   $_[0]->config('bg')     }

## -----------------------------------
## Setters..
## -----------------------------------

sub add_point  { my( $self, @coord         ) = @_; push @{$self->{'points'}}, [@coord];     $self }
sub add_points { my( $self, @points        ) = @_; push @{$self->{'points'}},  @points;     $self }
sub add_line   { my( $self, @coord         ) = @_; push @{$self->{'lines'}},  [@coord];     $self }
sub add_lines  { my( $self, @lines         ) = @_; push @{$self->{'lines'}},   @lines;      $self }
sub set_size   { my( $self, $w, $h         ) = @_; $self->{'size'}  = [ $w, $h ];           $self }
sub set_range  { my( $self, $l, $b, $r, $t ) = @_; $self->{'range'} = [ $l, $b, $r, $t ];   $self }
sub set_scale  { my( $self, $scale         ) = @_; $self->{'scale'} = $scale;               $self }

sub update_config { my( $self, %pars ) = @_;
  ( exists $self->{'config'}{$_} ) && ( $self->{'config'}{$_} = $pars{$_} ) for keys %pars; $self }

## --------------------------------------------------------
## The real code - no direct references to the $self hash!
## --------------------------------------------------------

sub load_data {
  my( $self, $fn, @t ) = @_;
  local $/ = undef;
  open my $ifh, '<', $fn;
    4 == (@t = split /,/) ? ( $self->add_line(  @t ) )     ## Length 4 - line
  : 2 == @t               ? ( $self->add_point( @t ) )     ## Length 2 - point
  :                         ( warn "input error: $_" )     ## o/w error
    for grep { /\S/ } split /\s+/, <$ifh>;
  close $ifh;
  $self;
}

sub compute_range {
  my $self = shift;
  my( $min_x,$min_y ) = my( $max_x,$max_y ) = @{ $self->points ? ($self->points)[0] : ($self->lines)[0] };

  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1])
    for $self->points, map { ($_,  [$_->[2],$_->[3]]) } $self->lines;

  $self->set_range( $min_x, $min_y, $max_x, $max_y );
}

sub add_line_of_best_fit {
  my $self = shift;
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = $self->points;

  $sx += $_->[0], $sxy += $_->[0]*$_->[1], $sy += $_->[1], $sxx += $_->[0]*$_->[0] for $self->points;

  return $self->add_line( $sx/$n, $self->min_y - $self->margin, $sx/$n, $self->max_y + $self->margin )
    unless $n*$sxx - $sx*$sx; ## special case of a vertical line

  my $b = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx ); my $a = ($sy-$b*$sx)/$n;
  my ( $l, $r, $d, $t ) = ( $self->min_x - $self->margin, $self->max_x + $self->margin,
       $self->min_y - $self->margin, $self->max_y + $self->margin );

  my $l_y = $a + $b * $l;
  my $r_y = $a + $b * $r;
  my $l_x = $l_y < $d ? ( ( $l_y = $d ) - $a)/$b : $l_y > $t ? ( ( $l_y = $t ) - $a)/$b : $l;
  my $r_x = $r_y < $d ? ( ( $r_y = $d ) - $a)/$b : $r_y > $t ? ( ( $r_y = $t ) - $a)/$b : $r;

  $self->add_line( $l_x, $l_y, $r_x, $r_y );
}

sub calculate_image_size {
  my $self = shift;

  my($W,$H,$width,$height) = ( $self->max_w, $self->max_h,
    $self->max_x-$self->min_x+2*$self->margin,$self->max_y-$self->min_y+2*$self->margin);
  ( $width/$height > $W/$H ) ? ( $H = $height/$width*$W ) : ( $W = $width/$height*$H );

  $self->set_size( $W, $H )->set_scale( $width / $W );
}

sub render_with_best_fit { shift->compute_range->add_line_of_best_fit->_render }
sub render {               shift->compute_range->_render                       }

sub _render {
  my $self = shift;

  $self->calculate_image_size;    ## Given max height/width work out the dimensions of image and the scale factor.
  my $margin = $self->margin;     ## Get margin...

  sprintf $SVG_TEMPLATE,
    $self->height, $self->width, $self->min_x - $margin, $self->min_y - $margin,
                   $self->max_x - $self->min_x + 2 * $margin, $self->max_y - $self->min_y + 2 * $margin,
    $self->border, $self->scale, $self->bg, $self->min_x - $margin, $self->min_y - $margin,
                   $self->max_x - $self->min_x + 2 * $margin, $self->max_y - $self->min_y + 2 * $margin,
    $self->color, $self->stroke * $self->scale, join( qq(\n    ), map { sprintf $LINE_TEMPLATE, @{$_} } $self->lines ), ## lines
    $self->fill, join( qq(\n    ), map { sprintf $POINT_TEMPLATE, @{$_}, $self->radius*$self->scale  } $self->points )  ## points
}

1;
