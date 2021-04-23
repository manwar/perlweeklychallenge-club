use strict;
use warnings;
##
# Write a script to list methods of a package/class.      
##
sub analyze{
    my($file) = @_;
    my @subs;
    my @uses; 
    my @subroutines;
    my $subs = `perlanalyst $file --analysis Sub`;
    $subs =~ s/$file://;
    @subs = split(/\n/, $subs);   
    my $uses = `perlanalyst $file --analysis Use`;
    $uses =~ s/$file://;
    @uses = split(/\n/, $uses);   
    for my $s (@subs){
        $s =~ s/\s+//;
        my @fields = split(/:/, $s); 
        push @subroutines, $fields[1] if(length($s) > 0); 
    }
    push @subroutines, "BEGIN" if(@uses); 
    return @subroutines; 
}

MAIN:{
    my $FILE = $ARGV[0];
    my @subroutines = analyze($FILE);
    print join("\n", sort {$a cmp $b} @subroutines) . "\n"; 
}
