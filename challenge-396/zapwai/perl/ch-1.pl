use v5.38;

sub proc($o, $f) {
    my @o = @$o;
    my @f = @$f;
    say "Input:  \@order = @o";
    say "\t\@friends = @f";
    my @out;
    for my $item (@o) {
	push @out, $item if (grep {$_ == $item} @f);
    }
    say "Output: @out";
}

my @order = (3,1,4,2,5);
my @friends = (1,2,4);
proc(\@order, \@friends);
@order = (5, 4, 3, 2, 1);
@friends = (1, 3, 5);
proc(\@order, \@friends);
@order = (2, 4, 1, 3);
@friends = (1, 2, 3, 4);
proc(\@order, \@friends);
@order = (4, 1, 3, 2);
@friends = (3);
proc(\@order, \@friends);
@order = (1, 3, 2, 6, 5, 4);
@friends = (1, 2, 3);
proc(\@order, \@friends);
