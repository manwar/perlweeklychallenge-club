use v5.38;

sub max_neg_pos{
    my %m;
    $m{-1} = 0;
    $m{1} = 0;
    do{ 
        $m{-1}++ if $_ < 0;
        $m{1}++ if $_ > 0;
    } for @_; 
    return $m{-1}, $m{1};  
}

my @max_neg_pos;  
my $max; 

@max_neg_pos = max_neg_pos -3, 1, 2, -1, 3, -2, 4;  
$max = (sort {$b <=> $a} @max_neg_pos)[0];  
say q/Count of positive integers: / . $max_neg_pos[1]; 
say q/Count of negative integers: / . $max_neg_pos[0]; 
say  q/Maximum of count of positive and negative integers: / . $max;
print qq/\n/;

@max_neg_pos = max_neg_pos -1, -2, -3, 1; 
$max = (sort {$b <=> $a} @max_neg_pos)[0];  
say q/Count of positive integers: / . $max_neg_pos[1]; 
say q/Count of negative integers: / . $max_neg_pos[0]; 
say  q/Maximum of count of positive and negative integers: / . $max;
print qq/\n/;

@max_neg_pos = max_neg_pos 1, 2; 
$max = (sort {$b <=> $a} @max_neg_pos)[0];  
say q/Count of positive integers: / . $max_neg_pos[1]; 
say q/Count of negative integers: / . $max_neg_pos[0]; 
say  q/Maximum of count of positive and negative integers: / . $max;
