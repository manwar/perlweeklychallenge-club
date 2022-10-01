use v5.36;

my @default = ( [qw/ab1234 cd5678 ef1342/], [qw/pq1122 rs3334/] );
my @input   = @ARGV ? @ARGV : $default[rand @default]->@*;

my $i      = '00';
my @output = map s/../$i++/er, @input;

say do { local $" = ', '; "Input:  @input\nOutput: @output" };
