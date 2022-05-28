package SVG;
use warnings;
use feature qw(say);
use Data::Dumper qw(Dumper);
use Const::Fast qw(const);

## -----------------------------------
## Constants - configuration & SVG templates...
## -----------------------------------

const my %DEF_CNF  => ( 'margin' => 40, 'max_w' => 960, 'max_h' => 540, 'color' => '#000',  'stroke' => 3,
                        'fill' => '#ccc',   'radius' => 10, 'border' => '#000', 'bg' => '#eee' );
const my $JOIN     => "\n      ";
const my $LN_TMPL  => '<line x1="%0.4f" y1="%0.4f" x2="%0.4f" y2="%0.4f" />';
const my $PT_TMPL  => '<circle cx="%0.4f" cy="%0.4f" r="%0.4f" />';
const my $SVG_TMPL => '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.0//EN" "http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd">
<svg height="%0.4f" width="%0.4f" viewBox="%0.4f %0.4f %0.4f %0.4f" xmlns="http://www.w3.org/2000/svg"
     xmlns:svg="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
  <rect stroke="%s" stroke-width="%0.4f" fill="%s" x="%0.4f" y="%0.4f" width="%0.4f" height="%0.4f" />
  <g transform="scale(1,-1) translate(0,%0.4f)">
    <g stroke="%s" stroke-width="%0.4f">
      %s
    </g>
    <g fill="%s">
      %s
    </g>
  </g>
</svg>';


## -----------------------------------
## Constructor
## -----------------------------------

sub new {
  bless my$s={'cnf'=>{%DEF_CNF},'scale'=>1,'points'=>[],'lines'=>[],'range'=>[],'size'=>[]},$_[0];
  $s->update_cnf(%{$_[1]||{}})->set_size($s->max_w,$s->max_h)->set_range(0,0,$s->max_w,$s->max_h )
}

## -----------------------------------
## Getters....
## -----------------------------------

sub min_x   {   $_[0]{'range'}[0]    }   sub min_y   {   $_[0]{'range'}[1]    }
sub max_x   {   $_[0]{'range'}[2]    }   sub max_y   {   $_[0]{'range'}[3]    }
sub width   {   $_[0]{'size'}[0]     }   sub height  {   $_[0]{'size'}[1]     }
sub points  { @{$_[0]{'points'}}     }   sub lines   { @{$_[0]{'lines'}}      }
sub scale   {   $_[0]{'scale'}       }   sub cnf     {   $_[0]{'cnf'}{$_[1]}  }
sub max_w   {   $_[0]->cnf('max_w')  }   sub max_h   {   $_[0]->cnf('max_h')  }
sub color   {   $_[0]->cnf('color')  }   sub stroke  {   $_[0]->cnf('stroke') }
sub fill    {   $_[0]->cnf('fill')   }   sub radius  {   $_[0]->cnf('radius') }
sub border  {   $_[0]->cnf('border') }   sub bg      {   $_[0]->cnf('bg')     }
sub margin  {   $_[0]->cnf('margin') }
sub bb_l { $_[0]->min_x-$_[0]->margin }  sub bb_r { $_[0]->max_x+$_[0]->margin }
sub bb_b { $_[0]->min_y-$_[0]->margin }  sub bb_t { $_[0]->max_y+$_[0]->margin }
sub bb_w { $_[0]->bb_r-$_[0]->bb_l    }  sub bb_h { $_[0]->bb_t-$_[0]->bb_b    }

## -----------------------------------
## Setters..
## -----------------------------------

sub add_point  { my $s = shift; push @{$s->{'points'}}, [@_]; $s }
sub add_points { my $s = shift; push @{$s->{'points'}},   @_; $s }
sub add_line   { my $s = shift; push @{$s->{'lines'}},  [@_]; $s }
sub add_lines  { my $s = shift; push @{$s->{'lines'}},    @_; $s }
sub set_size   { my $s = shift; $s->{'size'}  =         [@_]; $s }
sub set_range  { my $s = shift; $s->{'range'} =         [@_]; $s }
sub set_scale  { my $s = shift; $s->{'scale'} =        $_[0]; $s }

sub update_cnf {my($s,%p)=@_; exists$s->{'cnf'}{$_}&&($s->{'cnf'}{$_}=$p{$_}) for keys %p; $s}

## --------------------------------------------------------
## The real code - no direct references to the $s hash!
## --------------------------------------------------------

sub load_data {
  local $/=undef, my( $s, $fn, @t ) = @_;
  open my $ifh, '<', $fn;
  4==(@t = split /,/) ? ($s->add_line(@t)) : 2==@t ? ($s->add_point(@t)) : (warn "Error: $_")
    for grep { /\S/ } split /\s+/, <$ifh>;
  close $ifh;
  $s;
}

sub compute_range {
  my $s = shift;
  my( $min_x,$min_y ) = my( $max_x,$max_y ) = @{ $s->points ? ($s->points)[0] : ($s->lines)[0] };

  ($_->[0]<$min_x)&&($min_x=$_->[0]), ($_->[0]>$max_x)&&($max_x=$_->[0]),
  ($_->[1]<$min_y)&&($min_y=$_->[1]), ($_->[1]>$max_y)&&($max_y=$_->[1])
    for $s->points, map { ($_,  [$_->[2],$_->[3]]) } $s->lines;

  $s->set_range( $min_x, $min_y, $max_x, $max_y );
}

sub add_line_of_best_fit {
  my $s = shift;
  my $sx = my $sy = my $sxy = my $sxx = 0, my $n = $s->points;

  $sx += $_->[0], $sxy += $_->[0]*$_->[1], $sy += $_->[1], $sxx += $_->[0]*$_->[0] for $s->points;

  return $s->add_line( $sx/$n, $s->bb_b, $sx/$n, $s->bb_t ) unless $n*$sxx - $sx*$sx;

  my   $b                   = ( $n*$sxy-$sx*$sy ) / ( $n*$sxx - $sx*$sx );
  my ( $a, $l, $r, $d, $t ) = ( ( $sy-$b*$sx ) / $n, $s->bb_l, $s->bb_r, $s->bb_b, $s->bb_t );
  my ( $l_y, $r_y         ) = ( $a+$b*$l, $a+$b*$r );
  my ( $l_x, $r_x         ) = ( $l_y<$d ? (($l_y=$d)-$a)/$b : $l_y>$t ? (($l_y=$t)-$a)/$b : $l,
                                $r_y<$d ? (($r_y=$d)-$a)/$b : $r_y>$t ? (($r_y=$t)-$a)/$b : $r );

  $s->add_line( $l_x, $l_y, $r_x, $r_y );
}

sub calculate_image_size {
  my $s = shift;

  my( $W, $H, $w, $h ) = ( $s->max_w, $s->max_h, $s->bb_w, $s->bb_h );

  ( $w/$h > $W/$H ) ? $s->set_size($W,$h/$w*$W)->set_scale($w/$W)
                    : $s->set_size($w/$h*$H,$H)->set_scale($h/$H);
}

sub render_with_best_fit { shift->compute_range->add_line_of_best_fit->_render }
sub render {               shift->compute_range->_render                       }

sub _render {
  my $s = shift;
  my $m = $s->calculate_image_size->margin;

  sprintf $SVG_TMPL, $s->height, $s->width, $s->bb_l, $s->bb_b, $s->bb_w, $s->bb_h,
    $s->border, $s->scale, $s->bg, $s->bb_l, $s->bb_b, $s->bb_w, $s->bb_h, -$s->bb_b-$s->bb_t,
    $s->color, $s->stroke * $s->scale, join( $JOIN, map { sprintf $LN_TMPL, @{$_} } $s->lines ),
    $s->fill, join( $JOIN, map { sprintf $PT_TMPL, @{$_}, $s->radius*$s->scale  } $s->points )
}

1;
