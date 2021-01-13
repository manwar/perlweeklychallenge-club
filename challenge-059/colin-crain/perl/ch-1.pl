use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

## acquire the locus value and the array representation
## of the linked list
my ($locus, @input) = @ARGV;
my $next = undef;
my $node;

## 1. convert the input commandline array into a linked list
while (scalar @input > 0) {
    my $value =  pop @input;
    $node = new Node($value, $next);
    $next = $node
}
## $node currently points to beginning of the list

my $prelist_first;
my $prelist_last;
my $postlist_first;
my $postlist_last;

while (defined $node) {
    ## 2a. if it is less than the given value, add it to
    ##     the end of the pre list
    if ($node->value < $locus) {
        defined $prelist_last ? $prelist_last->next($node)
                              : ($prelist_first = $node);
        $prelist_last = $node;
    }
    ## 2b. if it is more than or equal to the given value
    ##     add it to the end of the post list
    else {
        defined $postlist_last ? $postlist_last->next($node)
                               : ($postlist_first = $node);
        $postlist_last = $node;
    }

    $node = $node->next;
}

## 3. link the pre list to the post list:

## 3a. point the last element of the pre list to
##     the first element of the post
$prelist_last->next($postlist_first) if (defined $prelist_last);

## 3b. point the last element of the post list to null
$postlist_last->{'next'} = undef;

## ## ## output

## if prelist never got made, start with the postlist
$node = $prelist_first || $postlist_first;
my @output;
while (defined $node) {
    push @output, $node->value;
    $node = $node->next;
}
say join ' → ', @output;


## ## ## ## ## NODE PACKAGE

package Node;

sub new {
    my ($class, $value, $next)  = @_;
    my $self     = { "value"    => $value,
                     "next"     => $next    };
    bless $self, $class;
    return $self;
}

sub value {
    my ($self, $value ) = @_;
    $self->{value} = $value if defined $value;
    return $self->{value}
}

sub next {
    my ($self, $next ) = @_;
    $self->{next} = $next if defined $next;
    return $self->{next}
}
