@a1= ( "00123", "-00123", "123" );
foreach $nr (@a1)  {
    if (substr($nr,0,1) == '0')  { $nr  =~ s/^0*//; }
    print "($nr)\n";
}


