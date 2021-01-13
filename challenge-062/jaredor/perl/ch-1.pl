#!/usr/bin/env perl

# PWC 062, TASK #1 : Sort Email Addresses

use v5.012;
use warnings;
use autodie;
use Getopt::Long;
use Pod::Usage;
use List::Util qw(first uniq);

# Validate Input

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions(
    'unique|u' => \( my $unique ),
    'help|h!'  => \( my $help ),
    'task|t!'  => \( my $task ),
    'test'     => \( my $test )
);

pod2usage(1) if $help;
pod2usage( -exitval => 0, -verbose => 2 ) if $task;

my @errors;
-r or push @errors, "File $_ is not readable or non-existent." for @ARGV;
pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

test() and exit() if $test;

# Get the solution.

my $list = get_emails();

my @bogus_emails = remove_bogus_emails($list);

say $_ for sort_emails( $list, $unique );

exit;    # End of main script.

#-------------------------------------------------------------------------------

sub get_emails {

    my $lref;
    s/\s//xmsg and /\S/ and push @{ $lref->{ lc $_ } }, $_ while (<>);
    return $lref;
}

sub remove_bogus_emails {
    my ( $lref, ) = @_;
    return map { @$_ } delete @$lref{ grep { 1 != tr/@/@/ } keys %$lref };
}

sub sort_emails {
    my ( $lref, $uniq ) = @_;

    my @keys_sorted =
      map  { $_->[1] }
      sort { $a->[0] cmp $b->[0] }
      map  { [ ( split '@' )[1], $_ ] }
      keys %$lref;

    my $select_uniq = sub {
        my ( %mailboxes, $m, $d );
        ( $m, $d ) = split '@' and push @{ $mailboxes{$m} }, $_ for @{ $_[0] };
        return map { ( sort @{ $mailboxes{$_} } )[0] } sort keys %mailboxes;
    };

    my $select_all = sub {
        return
          map { $_->[1] }
          sort { $a->[0] cmp $b->[0] }
          map { [ ( split '@' )[0], $_ ] } @{ $_[0] };
    };

    my $select = $uniq ? $select_uniq : $select_all;

    return map { $select->($_) } @$lref{@keys_sorted};
}

sub test {

    use Test::More;

    require File::Temp;
    use File::Temp ();
    use File::Temp qw/ :seekable /;
    close STDIN;

    my ( $lref, $aref, $uflag );
    my ( @list, @answ );

    # Test get_emails()

    my ( $tmp, ) = File::Temp->new();
    print $tmp q{
        name@example.org
        rjt@cpan.org
        Name@example.org
        rjt@CPAN.org
        user@alpha.example.org
    };
    close $tmp;
    @ARGV = ( $tmp->filename, );

    $lref = get_emails();
    $aref = {
        'user@alpha.example.org' => ['user@alpha.example.org'],
        'rjt@cpan.org'           => [ 'rjt@cpan.org', 'rjt@CPAN.org' ],
        'name@example.org'       => [ 'name@example.org', 'Name@example.org' ],
    };
    is_deeply( $lref, $aref, 'Task Example.' );

    # Test remove_bogus_emails()

    # First add in the bogus emails.

    open my $fh, '>>', $tmp->filename;
    say $fh 'bogusATbogusATbogus.com';
    say $fh 'bogus@bogus@bogus.com';
    close $fh;
    $aref->{'bogusatbogusatbogus.com'} = [ 'bogusATbogusATbogus.com', ];
    $aref->{'bogus@bogus@bogus.com'}   = [ 'bogus@bogus@bogus.com', ];
    @ARGV                              = ( $tmp->filename, );
    $lref                              = get_emails();
    is_deeply( $lref, $aref, 'Task Example with two bogus emails added.' );

    # Now take them out.
    delete $aref->{'bogusatbogusatbogus.com'};
    delete $aref->{'bogus@bogus@bogus.com'};
    my @bogus_emails = remove_bogus_emails($lref);
    is_deeply( $lref, $aref,
        'Task Example with two added bogus emails now removed.' );

    # Test sort_emails() default

    $uflag = 0;

    @list = sort_emails( $lref, $uflag );
    @answ = (
        'user@alpha.example.org', 'rjt@cpan.org',
        'rjt@CPAN.org',           'Name@example.org',
        'name@example.org',
    );
    is_deeply( \@list, \@answ, 'Task Example with regular sort.' );

    # Test sort_emails() unique

    $uflag = 1;

    @list = sort_emails( $lref, $uflag );
    @answ = (
        'user@alpha.example.org', 'rjt@CPAN.org',
        'Name@example.org',       'name@example.org',
    );
    is_deeply( \@list, \@answ, 'Task Example with unique sort.' );

    done_testing();
}

__END__

=head1 NAME

PWC 062, TASK #1 : Sort Email Addresses

=head1 SYNOPSIS

  ch-1.pl [options] [ file_1 ... ]

  Options:
    --unique      Output one physical address per logical address.
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    One or more files that consist solely of one email address per line.

    If no arguments are given, input data will be read from STDIN.

=head1 OPTIONS

=over 8

=item B<--unique>

Implement a -u option analogous to the sort -u option. Since only the domain of
an email address is case-insensitive, this means that email addresses that only
differ by the case of the domain are functionally equivalent. When --unique is
used, the script must "decide" which email to use for all the functionally
equivalent ones.

=item B<--help>

Brief help message.

=item B<--task>

Complete description of task and the script's attempt to satisfy it.

=item B<--test>

Run the embedded test suite for this script.

=back

=head1 DESCRIPTION

Write a script that takes a list of email addresses (one per line) and sorts
them first by the domain part of the email address, and then by the part to the
left of the @ (known as the mailbox).

Note that the domain is case-insensitive, while the mailbox part is case
sensitive. (Some email providers choose to ignore case, but that's another
matter entirely.)

If your script is invoked with arguments, it should treat them as file names and
read them in order, otherwise your script should read email addresses from
standard input.

=head2 Bonus

Add a -u option which only includes unique email addresses in the output, just
like sort -u.

=head2 Example

If given the following list:

    name@example.org
    rjt@cpan.org
    Name@example.org
    rjt@CPAN.org
    user@alpha.example.org

Your script (without -u) would return:

    user@alpha.example.org
    rjt@cpan.org
    rjt@CPAN.org
    Name@example.org
    name@example.org

With -u, the script would return:

    user@alpha.example.org
    rjt@CPAN.org
    Name@example.org
    name@example.org

=head1 INTERPRETATION

The problem statement seems to imply a requirement that email addresses have
one and only one "@" symbol. In this script, only those strings with exactly
one "@" symbol will be sorted and output. The strings that fail this test,
"bogus emails" will be discarded. The script saves the discarded strings in a
separate array for testing and debugging purposes.

One ambiguity is in how the unique address will be selected from a group of
functionally equivalent addresses. The example given narrows down the number of
ways to do this, there are still two plausible ones: 1) select the last
functionally equivalent email encountered; 2) select the one that would sort to
first position;

For this script when a unique email is requested of a group of functionally
equivalent emails, the first email in the sorted group is returned.

=cut
