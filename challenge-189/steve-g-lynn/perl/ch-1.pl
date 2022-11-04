#!/usr/bin/env perl

print &greater_character('b',qw/e m u g/),"\n";
print &greater_character('a',qw/d c e f/),"\n";
print &greater_character('o',qw/j a r/),"\n";
print &greater_character('a',qw/d c a f/),"\n";
print &greater_character('v',qw/t g a l/),"\n";

sub greater_character {
    my ($target,@arry)=@_;
    
    @arry=sort {$a cmp $b} @arry;
    
    for my $i (@arry) {
        ($i gt $target) && (return $i);
    }
    return $target;
}

