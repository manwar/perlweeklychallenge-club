#!/usr/bin/perl
use 5.038;
use warnings;
use Data::Dumper;
$Data::Dumper::Terse = 1;
$Data::Dumper::Indent = 1;

sub mergeAccounts ($accounts) {
    my %emailToName;
    my %emailToEmails;

    for my $account (@{$accounts}) {
        my $name = $account->[0];
        my @emails = @{$account}[1 .. scalar @{$account} - 1];

        for my $email (@emails) {
            $emailToName{$email} = $name;
        }

        for my $email (@emails) {
            $emailToEmails{$email} //= {};
            for my $connected (@emails) {
                $emailToEmails{$email}->{$connected} = 1;
            }
        }
    }

    my %seen;
    my @result;

    for my $email (keys %emailToEmails) {
        if ($seen{$email}) {
            next;
        }

        # Find all connected emails using BFS
        my @q = ($email);
        my $i = 0;
        while ($i < @q) {
            my $current = $q[$i++];
            for my $connected (keys %{$emailToEmails{$current}}) {
                unless ($seen{$connected}) {
                    $seen{$connected} = 1;
                    push @q, $connected;
                }
            }
        }

        my $name = $emailToName{$email};
        push @result, [$name, sort(unique(@q))];
    }

    return \@result;
}

sub unique(@list) {
    my %elems;
    for (@list) {
        $elems{$_}++;
    }

    return (keys %elems);
}

sub getAccountsFrom($filename) {
    open my $fh, '<', $filename or die "Could not open file: $!";
    local $/ = undef;
    my $content = <$fh>;
    close $fh;
    my $accounts = eval $content || die "Could not eval content: $@"; ## no critic
    return $accounts;
}

say Dumper(mergeAccounts(getAccountsFrom($ARGV[0])));