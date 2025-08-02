
sub f {
    my %box;
    pop =~ s/(.)(.)/ $box{$2} .= $1 /ger;
    0 + grep /R/ & /G/ & /B/, values %box
}

sub g {
    my %box;
    /(.)(.)/, $box{$2}.=$1 for pop =~ /../g;
    0 + grep /R/ * /G/ * /B/, values %box
}

sub h {
    my %box;
    /./, $box{ $' }{ $& } = 1 for pop =~ /../g;
    0 + grep keys %$_ == 3, values %box
}

sub i {
    my($s,%box)=@_;
    ($s=~s/(.)(.)// and $box{$2}.=$1) ? i( $s, %box ) : 0 + grep /R/ & /G/ & /B/, values %box
}


print f( $$_[0] ) == $$_[1] ? "ok\n" : "err\n" for
[ "G0B1R2R0B0" => 1 ],
[ "G1R3R6B3G6B1B6R1G3" => 3 ],
[ "B3B2G1B3" => 0 ],
[ "RaGaBaBbGbRcBbGcRbRdBdGcRcRcGaRbBdBeRfReGeReBe" => 3],
[ "RaGaBaGbBbRcGcBdGdRdBeReGeRfGfBfRg" => 4]
    
