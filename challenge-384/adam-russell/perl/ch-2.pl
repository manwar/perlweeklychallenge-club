use feature q/say/;
 
sub sublists{
    my @sublists; 
    for my $i (0 .. @_ - 1){
        for my $j ($i .. @_ - 1){
            push @sublists, [@_[$i .. $j]];
        }
    } 
    return @sublists; 
}

sub check_balance{
    my($x) = @_;
    return @{$x}/2 == unpack("%32I*", pack("I*", @{$x}));  
}

while(<DATA>){
    chomp;
    print $_;
    print qq/:\n/;
    my @s = grep { check_balance $_ } grep { join(q//, @{$_}) !~ /(.)(?!\1).+(?=\1)/g } sublists split //, $_;  
    my %h; do { $h{join q//, @{$_}} = undef } for @s; 
    do { say qq/\t/ . $_ } for keys %h;
} 

__DATA__
0101
000111
000011
10011100
00000
