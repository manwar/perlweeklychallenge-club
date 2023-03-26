# The Weekly Challenge 209
# Task 2 Merge Account
use v5.30.0;
use warnings;
use Graph::Undirected;
use Array::Utils qw/unique/;

my @accounts1 = (    ['A', 'a1@a.com', 'a2@a.com'],
                     ['B', 'b1@b.com'],
                     ['A', 'a3@a.com', 'a1@a.com'] );


my @accounts2 = (    ['A', 'a1@a.com', 'a2@a.com'],
                     ['B', 'b1@b.com'],
                     ['A', 'a3@a.com'],
                     ['B', 'b2@b.com', 'b1@b.com'] );

sub merge_acc {
    my @acc = @_;
    my @acc_mail = ();
    my %acc_name;
    for my $i (0..$#acc) {
        $acc_name{$i} = $acc[$i][0];
        $acc_mail[$i] = [@{$acc[$i]}[1..$acc[$i]->$#*]];
    }
    my %mail_acc;
    for my $i (0..$#acc) {
        for my $m ($acc_mail[$i]->@*) {
            push $mail_acc{$m}->@*, $i if defined($mail_acc{$m});
            $mail_acc{$m} = [$i] if !defined($mail_acc{$m});
        }
    }

    my $g = Graph::Undirected->new;
    $g->add_vertex($_) foreach 0..$#acc;
    for my $m (keys %mail_acc) {
        if (scalar $mail_acc{$m}->@* > 1) {
            for my $i (0..$mail_acc{$m}->$#*-1) {
                $g->add_edge($mail_acc{$m}->[$i], $mail_acc{$m}->[$i+1]);
                # can be enhanced to add edge between more accounts
            }
        }
    }

    my @cc = $g->connected_components();
    my @ans = ();
    for my $c (@cc) {
        my @arr;
        @arr = unique map {$acc_mail[$_]->@*} $c->@*;
        unshift @arr, $acc_name{$c->[0]};
        push @ans, [@arr]
    } 
    return @ans;
}

my @result1 = merge_acc(@accounts1);
my @result2 = merge_acc(@accounts2);

=pod From Data::Printer
@result1;

[
    [0] [
            [0] "A",
            [1] "a2@a.com",
            [2] "a3@a.com",
            [3] "a1@a.com"
        ],
    [1] [
            [0] "B",
            [1] "b1@b.com"
        ]
]

@result2;
[
    [0] [
            [0] "A",
            [1] "a3@a.com"
        ],
    [1] [
            [0] "B",
            [1] "b1@b.com",
            [2] "b2@b.com"
        ],
    [2] [
            [0] "A",
            [1] "a2@a.com",
            [2] "a1@a.com"
        ]
]


