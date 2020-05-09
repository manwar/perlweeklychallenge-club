#!/usr/bin/perl
use strict;

{ package item;

    sub new
    {
        my ($class) = @_;
        bless {
            _value => $_[1],
            _next => $_[2],
        }, $class;
    }

    sub value { $_[0]->{_value}}

    sub inext {
        my ($self, $newnext) = @_;
        $self->{_next} = $newnext if defined($newnext);
        return $self->{_next};
    }

    sub unlink {
        my ($self) = @_;
        $self->{_next} = undef;
        return $self->{_next};
    }
}

#my @input = (2,1, 2,3);
#my $K = 2;

my @input = (5,6,3,2,7,9);
my $K = 6;

#my @input = (1 , 4, 3, 2, 5, 2 );
#my $K = 3;

# my @input = (2 , 4, 3, 1, 5, 1 );
 #  my $K = 3;

my ($head, $smallpivot, $inusepivot);
my $ll;


sub make_linked_list {
    my @temp_list = @_;
    $ll->[$#temp_list] = item->new( $temp_list[$#temp_list] , \(undef) );
    for (reverse 0..$#temp_list-1) {
        $ll->[$_] = item->new($temp_list[$_] , \( $ll->[$_+1] ) ); 
    }
    $head = \($ll->[0]);
}



my $HELPER = -1;
make_linked_list($HELPER, @input);

$smallpivot = $head;
$inusepivot = ${$head}->inext;

sub print_linked_listi {   #for testing use 
    my $i = 0;
    my $t = ${$head};
    while( $t = ${$t->inext} and $i<10) {
        print $t->value, "->";
        $i++;
    }
    print "nil\n";
}

sub print_linked_list {
    my $t = ${$head};
    while( $t = ${$t->inext} ) {
        print $t->value, "->";
    }
    print "nil\n";
}


print "\nbefore: ";
print_linked_list;
print "\n";

my $j = 0;

my $previous = $head;
while( 1) {  #j is for testing help  

    #    print $$inusepivot->value, " " ,$$smallpivot->value, " \n"; 
    # print_linked_list;print "\n";

    if ($$inusepivot->value < $K) {
        $$previous->unlink;
        $$previous->inext( $$inusepivot->inext );

        $$inusepivot->unlink;
        $$inusepivot->inext($$smallpivot->inext);
        
        $$smallpivot->unlink;
        $$smallpivot->inext($inusepivot);
        $smallpivot = $inusepivot;

    }


    if (($$previous->inext != \undef) and ($$inusepivot->inext != \undef)) {
        $previous = $inusepivot;
        $inusepivot = $$inusepivot->inext;
    }
    else {
        print "\nafter : ";
        print_linked_list;
        exit;
    }

}



