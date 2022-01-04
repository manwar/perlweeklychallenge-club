#! /usr/bin/perl6

use Test;
plan 2;

is-deeply(p_gp('3/5'),['3/2','1/2'],'example 1');
is-deeply(p_gp('4/3'),['1/3','1/2'],'example 2');

class LocalFraction {
    has $.n is rw = 1;
    has $.d is rw = 1;

    method get_parent {
        my $p=LocalFraction.new();
        $p.n=self.n;
        $p.d=self.d;
        if ($p.n < $p.d) {
            $p.d -= $p.n;
        } else {
            $p.n -= $p.d;
        }
        return $p;
    }

    method stringify {
        return join('/',self.n,self.d);
    }

    method set_from_string($s) {
        if ($s ~~ /^(<[0..9]>+)\/(<[0..9]>+)$/) {
            self.n=$0;
            self.d=$1;
        }
        return self
    }

}

sub p_gp($s) {
    my $f=LocalFraction.new().set_from_string($s);
    my @out;
    for (1..2) {
        $f=$f.get_parent();
        push @out,$f.stringify();
    }
    return @out;
}
