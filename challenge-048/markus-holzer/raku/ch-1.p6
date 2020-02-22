role Concatenationem { has $.vicinus is rw; }
class Moribunda is Int does Concatenationem { };

sub bicimare-sine-fine( Int $homines where * > 1 ) 
{
    my $armis = my $primus = Moribunda.new(1);

    for 2..$homines
    { 
        my $homine = Moribunda.new($_); 
        $armis.vicinus = $homine; 
        $armis = $homine; 
    }
    
    $armis = $armis.vicinus = $primus;

    while $armis != $armis.vicinus 
    {
        $armis = $armis.vicinus = $armis.vicinus.vicinus;
    }

    $armis;
}

say bicimare-sine-fine( 50 );