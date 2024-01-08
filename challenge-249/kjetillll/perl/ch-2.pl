#!/usr/bin/perl
#https://theweeklychallenge.org/blog/perl-weekly-challenge-249/
use strict; use warnings; no warnings 'recursion'; use v5.10;

sub DI_perm {
    my($str, $i, $d) = @_ == 3 ? @_ : ( $_[0] =~ s/.$/$&$&/r, 0, length $_[0] );
    $str =~ /./ ? ( $& eq 'I' ? $i++ : $d--, DI_perm( $', $i, $d ) ) : ()
}

#--------------------------------------------------------------------------------

if( @ARGV ) { say join' ', DI_perm( $ARGV[0] ) }
else        { run_tests() }

sub run_tests {
    for(
	[ "IDID" => 0, 4, 1, 3, 2 ],
	[ "III" =>  0, 1, 2, 3 ],
	[ "DDI" =>  3, 2, 0, 1 ],
	[ join'',map{.5<rand?'I':'D'}0..29 ],
    ){
    my( $input, @expected ) = @$_;
    my @got = DI_perm( $input );
    printf "%s   input: $input   got: @got   expected: @expected\n", "@expected" eq "@got" ? 'ok' : '***NOT OK' if @expected;
    check_result($input,@got);
  }
}

sub check_result {
    my($s, @perm)=@_;
    my @s=split//,$s;
    for my $i (0..$#s){
	die if $s[$i] eq 'I' and not $perm[$i] < $perm[$i+1] ;
	die if $s[$i] eq 'D' and not $perm[$i] > $perm[$i+1] ;
    }
    die if "@{[ sort{$a<=>$b}@perm ]}" ne "@{[ 0 .. @s ]}";
    print "ok   check: $s     => @perm\n";
}
