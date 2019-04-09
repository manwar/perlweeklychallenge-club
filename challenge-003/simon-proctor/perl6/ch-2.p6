#!/usr/bin/env perl6

sub pad( Str $val, Int $len ) {
    my $rpad = " " x ( 1 + ( ( $len - $val.codes ) div 2 ) );
    my $lpad = " " x ( 1 + ( ( $len - $val.codes ) % 2 ) );
    return "{$lpad}{$val}{$rpad}";
}

multi sub MAIN( Int() $lines is copy where * > 2 ) {
    my @row = (1);
    my @out = [ [1], ];
    $lines--;
    my $max = 1;
    
    repeat {
        @row = (0, |(@row)) Z+ (|(@row), 0);
        @out.push( @row.clone );
        $max = @row.max;
        $lines--;
    } while ( $lines );

    my $len = $max.codes;

    @out = @out.map( -> @list { @list.map( { pad($_.Str,$len) } ).join("") } );

    $len = @out[*-1].codes;
    
    @out.map( { ( " " x ( ($len - $_.codes) div 2) ) ~ "$_" } ).join("\n").say;
}

multi sub MAIN($) {
    note "Please input a number of lines that must be at least 3";
}
