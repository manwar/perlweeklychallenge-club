#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-1.pl Perl Weekly Challenge Week 184 Task 1 Sequence Number
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given list of strings in the format aa9999 i.e. first 2 characters
# can be anything 'a-z' followed by 4 digits '0-9'.
# Write a script to replace the first two characters with sequence starting
# with '00', '01', '02' etc.
# Example 1 Input: @list = ('ab1234', 'cd5678', 'ef1342')
#          Output:         ('001234', '015678', '021342')
# Example 2 Input: @list =  'pq1122', 'rs3334')
#          Output:         ('001122', '013334')
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

my $format = qr/[a-z]{2}\d{4}/;

for ( @ARGV )
{
    warn "Expect format aa9999, got $_" unless m/$format/;
}

say showArray( seqNum( grep /$format/, @ARGV ) );

sub showArray(@array)
{
    return '()' unless @array;
    return "('" . join("', '", @array) . "')";
}

sub seqNum(@list)
{
    # There's quite a lot of subtle Perl going on in one line here.
    #
    # Within the map, The return value of s/// is the number of
    # substitutions,  not the string. To get a list of substituted
    # strings, we need to return it explicitly.
    #
    # If we do the substitution to the $_ variable in the map, then we are
    # modifying the original list.  If we want to keep the original list
    # intact, we need to copy to a temporary variable and return that. The
    # copy is done 'en passant' to be able to use the s/// operator in the
    # same assignment statement; the idiom is: (my $copy=$orig) =~ s///.
    #
    # s///e evaluates the second part of s/// as Perl code and uses the
    # result to substitue for what matched in the first part.
    # Here we are using /e to incorporate the sequence number increment as a
    # side effect of formatting the number before replacement in the string.
    #
    # $seq is post-incremented, so that the counter starts at 0.
    #
    # Increment the $seq variable, using sprintf(%02d) to get a two-digit
    # number with leading zero.  If it overflows past 99, wrap around to 00.
    my $seq = 0;
    return map { (my $n = $_) =~ s/^../sprintf("%02d", $seq++ % 100)/e; $n } @list;
    # return map { $_ =~ s/^../sprintf("%02d", $seq++ % 100)/e; $_ } @list;

    # Alternative in two steps, remove the prefix and insert the sequence
    # Does not modify the original list.
    # return map { sprintf("%02d$_", ($seq++ % 100)) } map { substr($_, 2) } @list;

    # Using Perl to write C. This modifies the original list.
    # for ( my $i = 0 ; $i <= $#list ; $i++ )
    # {
    #     my $seq = sprintf("%02d", $i%100);
    #     $list[$i] = $seq . substr($list[$i], 2);
    # }
    # return @list;
}


sub runTest
{
    use Test2::V0;

    my @output;
    @output = seqNum('ab1234', 'cd5678', 'ef1342');
    is( \@output,  [ '001234', '015678', '021342' ], "Example 1");
    @output = seqNum('pq1122', 'rs3334');
    is( \@output,  [ '001122', '013334' ],           "Example 2");

    done_testing;
}
