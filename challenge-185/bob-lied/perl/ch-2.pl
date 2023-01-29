#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 185 Task 2 Mask Code
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given a list of codes in many random format.
# Write a script to mask first four characters (a-z,0-9) and keep the rest
# as it is.
# Example 1
#   Input: @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy')
#  Output: ('xx-xxe-123', 'xxx.xbc.420', 'xxxx-0010.xy')
# Example 2
#   Input: @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f')
#  Output: ('xxxx567.a', 'x-xxx4-bc', 'x.x.x.x.e.f')
#=============================================================================

use v5.36;

use constant MAXREPLACE => 4;
my $TOREPLACE = qr([a-z0-9]);

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

if ( @ARGV )
{
    say "(", join(', ', maskCode(@ARGV) ), ")";
}
else
{
    my @list;
    @list = ('ab-cde-123', '123.abc.420', '3abc-0010.xy');
    say "(", join(', ', maskCode(@list) ), ")";
    @list = ('1234567.a', 'a-1234-bc', 'a.b.c.d.e.f');
    say "(", join(', ', maskCode(@list) ), ")";
}

sub maskCode(@list) { map { _mask($_, 4) } @list }

sub _mask($s, $max=MAXREPLACE)
{
    my $t = $s;
    # Use /g to loop over matches, setting pos each time
    while ( $s =~ m/$TOREPLACE/g && $max-- )
    {
        # This would reset pos for $s, so operate on t instead
        substr($t, pos($s)-1, 1) = 'x';
        say " AFTER: '$s' pos=", pos($s), "'$t'" if $Verbose;
    }
    return $t;
}

sub runTest
{
    use Test2::V0;

    is( _mask('ab-cde-123'   ), 'xx-xxe-123',   "Example 1-a");
    is( _mask('123.abc.420'  ), 'xxx.xbc.420',  "Example 1-b");
    is( _mask('3abc-0010.xy' ), 'xxxx-0010.xy', "Example 1-c");
    is( _mask('1234567.a'    ), 'xxxx567.a',    "Example 2-a");
    is( _mask('a-1234-bc'    ), 'x-xxx4-bc',    "Example 2-b");
    is( _mask('a.b.c.d.e.f'  ), 'x.x.x.x.e.f',  "Example 2-c");
    is( _mask('GHI1234MNO'   ), 'GHIxxxxMNO',   "Middle");
    is( _mask('a12--'        ), 'xxx--',        "Less than 4");
    is( _mask(''             ), '',             "Empty string");
    is( _mask('.....'        ), '.....',        "None");

    done_testing;
}

