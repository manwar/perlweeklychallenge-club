
#run like: perl ch-1.pl

use Carp;

sub zip(\@\@){
    my($a,$b)=@_;
    croak 'Args have unequal size' if @$a != @$b;
    map { $$a[$_], $$b[$_] } 0..$#$a;
}

my @a = qw/1 2 3/;
my @b = qw/a b c/;

my @result = zip(@a,@b);

print "qw/@result/\n";
