use strict;
use warnings;
package LinkedList{
    use boolean;
    use Tie::RefHash;
    use Class::Struct;
    package Node{
        use Class::Struct;

        struct(
            data => q/$/,
            next => q/Node/
        );
    }

    struct(
        head => q/Node/
    );

    sub stringify{
        my($self) = @_;
        my $s = "";
        my $next = $self->head()->next();
        while($next && $next->next()){
            $s .= " -> " if $s; 
            $s = $s . $next->data();
            $next = $next->next();
        }
        $s = $s . " -> " . $next->data() if $next->data();
        $s .= "\n"; 
        return $s;
    }

    sub insert{
        my($self, $data, $previous) = @_;
        if(!$previous){
            $previous=new Node(data => undef, next => undef);
            $self->head($previous);
        }
        my $next=new Node(data => $data, next => undef);
        $previous->next($next);
        return $next;
    }

    sub in_list{
        my($self, $k) = @_;
        my $previous = $self->head();
        my $next = $self->head()->next();
        tie my %node_value, "Tie::RefHash";
        while($next){
            return true if($next->data() == $k); 
            $next = $next->next(); 
        }
        return false;
    }
    true;
}   
