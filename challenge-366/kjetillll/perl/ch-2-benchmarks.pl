use strict; use warnings; use v5.10; use Benchmark;

sub f1 { #slow
    my $pattern = shift =~ s/\?/./gr;
    my $count = 0;
    for my $hh ( "00" .. "23" ) {
    for my $mm ( "00" .. "59" ) {
        $count++ if "$hh:$mm" =~ /$pattern/;
    } }
    return $count
}

sub f2 { #also slow
    my $pattern = shift =~ s/\?/./gr;
    state $hhmm_list = join ' ', map { my $mm = $_; map "$_:$mm", "00".."23" } "00".."59";
    scalar map 1, $hhmm_list =~ /$pattern/g;
}

sub f3 { #fast
    my($a, $b, $c ,$d) = ( shift =~ /(.)(.):(.)(.)/ );
      ( $a.$b eq '??'           ? 24
      : $a    eq '?'  && $b < 4 ?  3
      : $a    eq '?'            ?  2
      : $b    eq '?'  && $a < 2 ? 10
      : $b    eq '?'            ?  4
      :                            1
      )
    * ( $c eq '?'               ?  6 : 1 )
    * ( $d eq '?'               ? 10 : 1 )
}


my @tests = ( [ "?2:34" =>    3 ],
              [ "?4:?0" =>   12 ],
              [ "??:??" => 1440 ],
              [ "?3:45" =>    3 ],
              [ "2?:15" =>    4 ],
              [ "2?:1?" =>   40 ],
              [ "2?:?7" =>   24 ],
              [ "1?:?7" =>   60 ],
              [ "1?:5?" =>  100 ] );

for my $f ( \&f1, \&f2, \&f3 ) {
    print &$f( $$_[0] ) == $$_[1] ? "ok " : "ERROR" for @tests;
    print "\n";
}

Benchmark::cmpthese( -1, {
    f1 => sub{ f1( $$_[0] ) for @tests },
    f2 => sub{ f2( $$_[0] ) for @tests },
    f3 => sub{ f3( $$_[0] ) for @tests },
});

__END__

Benchmark output:

       Rate     f1     f2     f3
f1    436/s     --   -79%  -100%
f2   2047/s   369%     --   -98%
f3 131522/s 30040%  6327%     --
