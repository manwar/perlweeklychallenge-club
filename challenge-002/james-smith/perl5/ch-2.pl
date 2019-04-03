use strict;

sub base35 {
    my $o = '';
    for( shift; $_; ) {
        $_ = ( $_ - (my $t  = $_%35) )/ 35;
        $o .= chr $t+($t<10?48:55);
    }
    return scalar reverse $o;
}

print $_,"\t", base35( $_ ),"\n" foreach @ARGV;

