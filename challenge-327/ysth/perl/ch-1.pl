use 5.036;

use Bit::Vector;

my @ints = @ARGV;

my $v = Bit::Vector->new_Bin(@ints + 1, 1);
$v->Index_List_Store(grep $_ > 0 && $_ <= @ints, @ints);
$v->Flip();
say for $v->Index_List_Read();
