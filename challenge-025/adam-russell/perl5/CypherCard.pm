package CypherCard;

use boolean;

sub new{
    my ($pkg, $attr) = @_;
    my $self = {}; 
    if(defined($attr->{suit}) && defined($attr->{rank}) && defined($attr->{letter})){   
        $self = $attr;
    }   
    bless($self, $pkg);
    return $self;    
}  

true;  
