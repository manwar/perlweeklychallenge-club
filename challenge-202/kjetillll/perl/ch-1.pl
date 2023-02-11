#!/usr/bin/perl

sub co3 { "@_" =~ / \b (-?\d+) \s (-?\d+) \s (-?\d+) \b (??{ $1*$2*$3 % 2 ? '' : '^' }) /x|0 }

for( [ (1,5,3,6) => 1 ],
     [ (2,6,3,5) => 0 ],
     [ (1,2,3,4) => 0 ],
     [ (2,3,5,7) => 1 ] )
{
    my $exp = pop@$_;
    my @arr = @$_;
    my $got = co3(@arr);
    printf "%-6s   inp: @arr   exp: $exp   got: $got\n", $exp==$got?'ok':'NOT OK';
}
