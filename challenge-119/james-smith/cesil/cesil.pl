use strict;

$| = 1;
my( $ptr, @in, %mem, @code, %ptrs, $reg ) = 0;

while(<>) {
  (@in = map { 0+$_ } <> ) && last if m{^ {8}%};
  ($ptrs{$1},$_)=(scalar @code,$2) if m{^(\S{1,7})\s+(.*)};
  push @code, [ split m{\s+}, s{^\s+}{}r =~ s{\s+$}{}r, 2 ];
}

my %commands = (
  'LINE'     => sub { print "\n"; },
  'IN'       => sub { die "RUN OUT OF INPUT" unless @in; $reg = shift @in; },
  'OUT'      => sub { print $reg },
  'PRINT'    => sub { print $_[0] =~ s{^"}{}r =~ s{"$}{}r; },
  'STORE'    => sub { $mem{$_[0]} = $reg; },
  'LOAD'     => sub { $reg = $mem{$_[0]}; },
  'HALT'     => sub { exit; },
  'JINEG'    => sub { $ptr = $ptrs{$_[0]} - 1 if $reg < 0; },
  'JIZERO'   => sub { $ptr = $ptrs{$_[0]} - 1 if $reg == 0; },
  'JUMP'     => sub { $ptr = $ptrs{$_[0]} - 1; },
  'ADD'      => sub { $reg += ( $_[0]=~m{^-?\d+$} ? $_[0] : $mem{$_[0]} ) },
  'SUBTRACT' => sub { $reg -= ( $_[0]=~m{^-?\d+$} ? $_[0] : $mem{$_[0]} ) },
  'MULTIPLY' => sub { $reg *= ( $_[0]=~m{^-?\d+$} ? $_[0] : $mem{$_[0]} ) },
  'DIVIDE'   => sub { $reg /= ( $_[0]=~m{^-?\d+$} ? $_[0] : $mem{$_[0]} ) ; $reg = int $reg; },
);

## Execution loop...
(&{ $commands{$code[$ptr][0]} }( $code[$ptr][1] ),$ptr++) foreach 1..1e6;


