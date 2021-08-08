#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( *@input ) ;

@input.elems == 0 && @input = (10, -15, 20, 30, -25, 0, 5, 40, -5);
my $total = @input.sum;
my $min   = $total;
my $half  = @input.elems div 2;
my @part1;

for @input.combinations($half) -> $c {
    my $psum = $c.sum;
    if ($total - 2 * $psum).abs < $min {
        $min = ($total - 2 * $psum).abs ;
        @part1 = |$c;
    }
}

my @part2 = (bag(@input) ∖ bag(@part1)).kxxv;;  ## multiset subtraction (set minus) operator


my $output = qq:to/END/; 
    {@part1.sort.reverse.join(' + ') ~ " = " ~ @part1.sum}
    {@part2.sort.reverse.join(' + ') ~ " = " ~ @part2.sum}
    END
    
say S:g/"+ -"/- / given $output;


