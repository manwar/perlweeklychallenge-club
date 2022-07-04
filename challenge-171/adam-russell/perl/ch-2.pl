use strict;
use warnings;
##
# Create sub compose($f, $g) which takes in two parameters $f and $g as subroutine refs 
# and returns subroutine ref i.e. compose($f, $g)->($x) = $f->($g->($x)).
##
sub f{
    my($x) = @_;
    return $x + $x;
}

sub g{
    my($x) = @_;
    return $x * $x;
}

sub compose{
    my($f, $g) = @_;
    return sub{
        my($x) = @_;
        return $f->($g->($x));
    };
}

MAIN:{
    my $h = compose(\&f, \&g);
    print $h->(7) . "\n";
}