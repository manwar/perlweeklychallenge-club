#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       cool-and-composed.pl
#
#         First-class Function
#         Submitted by: Mohammad S Anwar

#         Create sub compose($f, $g) which takes in two parameters $f and
#         $g as subroutine refs and returns subroutine ref i.e. compose($f,
#         $g)->($x) = $f->($g->($x))
# 
# 
#         e.g.
# 
#         $f = (one or more parameters function)
#         $g = (one or more parameters function)
# 
#         $h = compose($f, $g)
#         $f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';


sub add    { $_[0] + $_[1] };
sub square { $_[0] ** 2    };

my $g = \&add;
my $f = \&square;

## or alternately done this way but I think it's less clear
# my $g = sub { $_[0] + $_[1] };
# my $f = sub { $_[0] ** 2    };


sub compose ( $f, $g) {
    return sub {$f->( $g->( @_ ) )};
}


my $c = compose( $f, $g );

say $c->( 2,3 );


