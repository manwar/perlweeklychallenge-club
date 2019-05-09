use strict;
use warnings;
use Const::Fast;
use List::Util;

# Download from https://crosswordman.com/wordlist.html :-

const my $WORD_FILE     => 'UK Advanced Cryptics Dictionary.txt';
const my $MAX_LADDER_SZ =>  10;
const my $DEFAULT_WORD1 => 'cold';
const my $DEFAULT_WORD2 => 'warm';

MAIN:
{
    my $word1      = $ARGV[0] // $DEFAULT_WORD1;
    my $word2      = $ARGV[1] // $DEFAULT_WORD2;
    my $dictionary = init_dictionary();
    my $wordlist   = $dictionary->[ length $word1 ];

    if (my @ladder = find_shortest_ladder($word1, $word2, $wordlist))
    {
        print "\nShortest ladder found:\n(",
               join(', ', map { '"' . $_ . '"' } @ladder), ")\n";
    }
    else
    {
        print "\nNo ladder found from '$word1' to '$word2'\n";
    }
}

sub init_dictionary
{
    my @dictionary;

    open(my $fh, '<', $WORD_FILE)
        or die "Cannot open file '$WORD_FILE' for reading, stopped";

    while (<$fh>)
    {
        next if 1 .. / ^ -+ $ /x;           # Skip header
        chomp;
        next if /[^a-z]/;                   # Skip capital letters, apostrophes,
                                            # hyphens, and phrases (whitespace)
        push $dictionary[ length ]->@*, $_;
    }

    close $fh
        or die "Cannot close file '$WORD_FILE', stopped";

    return \@dictionary;
}

sub find_shortest_ladder
{
    my ($word1, $word2, $wordlist) = @_;
    my  @solution;

    if (args_are_valid($word1, $word2, $wordlist))
    {
        my @ladders = ( Ladder->new($word1, $word2, [ $word1 ], $wordlist) );

        OUTER:
        for (1 .. $MAX_LADDER_SZ)
        {
            my @new_ladders;

            while (my $ladder = shift @ladders)
            {
                for my $next ($ladder->get_next_words()->@*)
                {
                    my @new_ladder = ($ladder->get_ladder()->@*, $next);

                    if ($next eq $word2)
                    {
                        @solution = @new_ladder;
                        last OUTER;
                    }

                    push @new_ladders,
                         Ladder->new($next, $word2, \@new_ladder, $wordlist);
                }
            }

            @ladders = @new_ladders;
        }
    }

    return @solution;
}

sub args_are_valid
{
    my ($w1, $w2, $list) = @_;
    my  $args_are_valid  = 0;

    if    (!defined $w1)
    {
        warn "\nFirst word is undefined";
    }
    elsif (!defined $w2)
    {
        warn "\nSecond word is undefined";
    }
    elsif ((my $l1 = length $w1) != (my $l2 = length $w2))
    {
        warn "\nUnequal word lengths: $w1($l1) and $w2($l2)";
    }
    elsif ($w1 eq $w2)
    {
        warn "\nInput words are equal";
    }
    elsif ((my $size = scalar @$list) <= 2)
    {
        warn sprintf("\nWord list contains %d element%s",
                      $size, ($size == 1) ? '' : 's');
    }
    elsif ($l1 != (my $l3 = length (my $w0 = $list->[0])))
    {
        warn "\nUnequal word lengths: $w1 ($l1) and $w0 ($l3) " .
              '[the first word in the list]';
    }
    elsif (List::Util::none { $w1 eq $_ } @$list)
    {
        warn "\n'$w1' not found in word list";
    }
    elsif (List::Util::none { $w2 eq $_ } @$list)
    {
        warn "\n'$w2' not found in word list";
    }
    else
    {
        $args_are_valid = 1;
    }

    return $args_are_valid;
}

package Ladder
{
    sub new
    {
        my ($class, $first, $last, $ladder, $wordlist) = @_;
        my  $self =
            {
                start_word => $first,
                end_word   => $last,
                ladder     => $ladder,
                wordlist   => $wordlist,
            };

        return bless $self, $class;
    }

    sub get_ladder
    {
        my ($self) = @_;

        return $self->{ladder};
    }

    sub get_next_words
    {
        my ($self)  = @_;
        my  $word1  = $self->{start_word};
        my  @ladder = $self->{ladder}->@*;
        my  @word1  = split //, $word1;
        my  $max_i  = length($word1) - 1;
        my  @candidates;

        for my $word2 ( $self->{wordlist}->@* )
        {
            next if List::Util::any { $word2 eq $_ } @ladder;


            my @word2 = split //, $word2;
            my $diffs = 0;

            for my $i (0 .. $max_i)
            {
                ++$diffs if $word1[$i] ne $word2[$i];
            }

            push @candidates, $word2 if $diffs == 1;
        }

        return \@candidates;
    }
}
