use List::Util qw( all sum );
use Benchmark qw( cmpthese );

sub f1 {
    local $_ = shift;
    s/(.)(.*?)\1/$2/ ? /$1/ ? f1($_) : 0 : 1
}

sub f2 {
    my $s = shift;
    $s =~ s/(.)(.*?)\1/$2/ ? $s =~ /$1/ ? f2($s) : 0 : 1
}

sub f3 {
    my $s = shift;
    while( $s=~s/(.)(.*?)\1/$2/ ){
        return 0 if $s !~ /$1/;
    }
    return 1
}

sub f4 {
    my %freq;
    $freq{ $_ }++ for split //, shift;
    ( grep $_ % 2 == 0, values %freq ) ? 0 : 1
}

sub f5 {
    my %freq;
    $freq{ $_ }++ for split //, shift;
    ( all { $_ % 2 == 1 } values %freq ) ? 1 : 0
}




my @f = ( \&f1, \&f2, \&f3, \&f4, \&f5 );
for my $f ( @f ) {
    print ! &$f('weekly')    ? "ok\n" : "error\n";
    print   &$f('perl')      ? "ok\n" : "error\n";
    print ! &$f('challenge') ? "ok\n" : "error\n";
}

sub rndstr { join'',map chr(97+rand 26), 1..shift }
srand(13);
my @s = map rndstr(10), 1 .. 40;
//, print join('',map &$_($'),@f)=~/^(0+|1+)$/ ? "ok $_\n" : "error $_\n" for @s;

cmpthese( 100_000, { f1 => sub{  f1($_) for @s },
                     f2 => sub{  f2($_) for @s },
                     f3 => sub{  f3($_) for @s },
                     f4 => sub{  f4($_) for @s },
                     f5 => sub{  f5($_) for @s } } );
__END__

     Rate   f4   f5   f1   f2   f3
f4 5721/s   --  -9% -16% -16% -17%
f5 6266/s  10%   --  -8%  -8% -10%
f1 6784/s  19%   8%   --  -0%  -2%
f2 6789/s  19%   8%   0%   --  -2%
f3 6930/s  21%  11%   2%   2%   --

f4 is slowest
f3 is fastest with these string lengths
