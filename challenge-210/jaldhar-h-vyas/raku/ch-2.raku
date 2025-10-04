#!/usr/bin/raku
use MONKEY-SEE-NO-EVAL;

sub mergeAccounts(@accounts) {
    my %emailToName;
    my %emailToEmails;

    for @accounts -> @account {
        my $name = @account[0];
        my @emails = @account[1..*];

        for @emails -> $email {
            %emailToName{$email} = $name;
        }

        for @emails -> $email {
            unless %emailToEmails{$email}:exists {
                %emailToEmails{$email} = Set.new();
            }
            %emailToEmails{$email} ∪= @emails.Set;
        }
    }

    # Second pass: merge connected components
    my %seen;
    my @result;

    for %emailToEmails.keys -> $email {
        if %seen{$email} {
            next;
        }

        # Find all connected emails using BFS
        my @q = [$email];
        my $i = 0;
        while $i < @q.elems {
            my $current = @q[$i++];
            for %emailToEmails{$current}.keys -> $connected {
                unless %seen{$connected} {
                    %seen{$connected} = True;
                    @q.push($connected);
                }
            }
        }

        # Sort emails and add to result, removing duplicates
        my $name = %emailToName{$email};
        @result.push([$name, |@q.unique.sort]);
    }

    return @result;
}

sub getAccountsFrom($filename) {
    my $content = $filename.IO.slurp;
    my @accounts = EVAL($content);
    return @accounts;
}

sub MAIN(
    Str $filename
) {
    mergeAccounts(getAccountsFrom($filename)).raku.say;
}