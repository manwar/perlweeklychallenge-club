#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

{   package My::Node;
    sub new { bless { start => $_[1], end => $_[2] }, $_[0] }
    sub edge_length {
        my ($self, $position) = @_;
        ($self->{end} < $position + 1
            ? $self->{end}
            : $position + 1
        ) - $self->{start}
    }
}

{   package My::Suffix::Tree;

    sub new {
        my ($class) = @_;
        bless my $self = {position      => -1,
                          text          => "",
                          active_edge   => 0,
                          active_length => 0,
                          current_node  => -1,
        }, $class;
        $self->{root} = $self->new_node(-1, -1);
        $self->{active_node} = $self->{root};
        return $self
    }

    sub add_numbers {
        my ($self, $node_index) = @_;
        my $node = $self->{nodes}[$node_index];
        for my $next_index (values %{ $node->{next} }) {
            undef $node->{numbers}{$_} for $self->add_numbers($next_index);
        }
        return $node->{number} // () unless exists $node->{numbers};

        return keys %{ $self->{numbers} }
    }

    sub add_words {
        my ($self, @words) = @_;
        $self->{number_of_words} = @ARGV;
        for my $word_index (0 .. $#words) {
            $self->add_char($_)
                for split //, "$words[$word_index]<$word_index>";
        }
        my $text_length = length $self->{text};
        for my $node (@{ $self->{nodes} }) {
            next if $node->{start} < 0;
            my $text = $node->{end} > $text_length
                     ? substr $self->{text}, $node->{start}
                     : substr $self->{text}, $node->{start},
                           $node->{end} - $node->{start};
            $node->{text} = $text;
            if (my ($number) =  $text =~ /<([0-9]+)>/) {
                $node->{number} = $number;
            }
        }
        $self->add_numbers(0);
    }

    sub _add_suffix_link {
        my ($self, $node) = @_;
        $self->{nodes}[ $self->{need_suffix_link} ]{link} = $node
            if $self->{need_suffix_link} > 0;
        $self->{need_suffix_link} = $node;
    }

    sub active_edge { substr $_[0]{text}, $_[0]{active_edge}, 1 }

    sub walk_down {
        my ($self, $next) = @_;
        $next //= 0;
        my $position = $self->{position};
        if ($self->{active_length}
            >= $self->{nodes}[$next]->edge_length($position)
        ) {
            $self->{active_edge}
                += $self->{nodes}[$next]->edge_length($position);
            $self->{active_length}
                -= $self->{nodes}[$next]->edge_length($position);
            $self->{active_node} = $next;
            return 1
        }
        return
    }

    sub new_node {
        my ($self, $start, $end) = @_;
        $self->{nodes}[ ++$self->{current_node} ]
            = 'My::Node'->new($start, $end);
        $self->{current_node}
    }

    sub add_char {
        my ($self, $char) = @_;
        substr $self->{text}, ++$self->{position}, 1, $char;
        $self->{need_suffix_link} = -1;
        ++$self->{remainder};
        while ($self->{remainder} > 0) {
            $self->{active_edge} = $self->{position}
                unless $self->{active_length};
            if (! exists
                $self->{nodes}[ $self->{active_node} ]
                    {next}{ $self->active_edge }
            ) {
                $self->{nodes}[ $self->{active_node} ]
                    {next}{ $self->active_edge }
                    = $self->new_node($self->{position}, 'INF');
                $self->_add_suffix_link($self->{active_node});  # Rule 2.
            } else {
                my $next = $self->{nodes}[ $self->{active_node} ]
                    {next}{ $self->active_edge };
                next if $self->walk_down($next);  # Observation 2.

                # Observation 1.
                if ($char eq substr $self->{text},
                        $self->{nodes}[$next]{start} + $self->{active_length}, 1
                ) {
                    ++$self->{active_length};
                    # Observation 3.
                    $self->_add_suffix_link($self->{active_node});
                    last
                }
                my $split = $self->new_node($self->{nodes}[$next]{start},
                    $self->{nodes}[$next]{start} + $self->{active_length});
                $self->{nodes}[ $self->{active_node} ]{next}
                    { $self->active_edge } = $split;
                my $leaf = $self->new_node($self->{position}, 'INF');
                $self->{nodes}[$split]{next}{$char} = $leaf;
                $self->{nodes}[$next]{start} += $self->{active_length};
                $self->{nodes}[$split]{next}{ substr $self->{text},
                    $self->{nodes}[$next]{start}, 1 } = $next;
                $self->_add_suffix_link($split);  # Rule 2.
            }
            -- $self->{remainder};

            if ($self->{active_node} == $self->{root}
                && $self->{active_length} > 0  # Rule 1.
            ) {
                --$self->{active_length};
                $self->{active_edge}
                    = $self->{position} - $self->{remainder} + 1;
            } else {
                $self->{nodes}[ $self->{active_node} ]{link} //= 0;
                $self->{active_node}
                    = $self->{nodes}[ $self->{active_node} ]{link} > 0
                    ? $self->{nodes}[ $self->{active_node} ]{link}
                    : $self->{root};  # Rule 3.
            }
        }
    }

    my @lcs;
    sub longest_common_substring {
        my ($self, $node_index, $string) = @_;
        @lcs = ("") unless $node_index;
        my $node = $self->{nodes}[$node_index];

        if ($self->{number_of_words} == keys %{ $node->{numbers} }) {
            my $compare_lengths = length $string <=> length $lcs[0];
            push @lcs, $string if $compare_lengths == 0;
            @lcs = ($string) if $compare_lengths == 1;
        }

        for my $next_char (keys %{ $node->{next} }) {
            my $next_index = $node->{next}{$next_char};
            my $next = $self->{nodes}[$next_index];
            $self->longest_common_substring(
                $next_index,
                "$string$next->{text}");
        }
        return @lcs
    }
}

my $o = 'My::Suffix::Tree'->new;
$o->add_words(@ARGV);

say "<$_>" for $o->longest_common_substring(0, "");
