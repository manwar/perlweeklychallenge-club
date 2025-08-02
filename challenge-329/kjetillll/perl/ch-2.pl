use strict; use warnings;

sub is_nice {
    my %uclc;
    $uclc{ lc() } |= 2-/[a-z]/ for split //, pop;
    ! grep $_ != 3, values %uclc
}

sub f1 {
    my $str = shift();
    my $l = length($str);
    my($max, $longest_nice) = (1, "");
    for my $offset ( 0 .. $l-1 ){
        for my $length ( $max+1 .. $l-$offset ){
            my $substr = substr($str, $offset, $length);
            ($max, $longest_nice) = ($length, $substr) if is_nice($substr)
        }
    }
    $longest_nice
}

sub f2 {
    my @fifo = @_;
    my %seen;
    while(@fifo){
        my $substr = shift @fifo;
        next if $seen{$substr}++;
        return $substr if is_nice($substr);
        push @fifo, substr $substr, 1, length($substr)-1;
        push @fifo, substr $substr, 0, length($substr)-1;
    }
    return "";
}

sub f3 {
    my @q = @_;
    my %seen;
    shift(@q) =~ /^(.)(.*)(.)$/ and !$seen{$&}++ and is_nice($&) ? return($&) : push @q, "$1$2", "$2$3" while @q;
    "";
}

/(\w+) *(\w*)/,
print f1($1) eq $2
   && f2($1) eq $2
   && f3($1) eq $2
? "ok    f('$1') eq '$2'\n" : "err\n"
for split /\n/, <<"";
YaaAho                         aaA
cC                             cC
A                              
jwWcXSjtdNHsaCcKCopYkCNnrCRqQc CNnrCRqQc
sfqZdwBJFrVDzGpqozoODyOdYkvFtP oODyOdY
DppVvddvPzBKFNCGxszuYtOGlRZDkl DppVvddvP
ijOhDVbarrILnIDVhsNTDVdRvrjJeF DVdRvrjJ
vDDajqCjFwvJyccKZpfPBzFbdYJsyI ZpfPBzFb
hhlJWCaiHachIhAHVEGJefJaYpDRUi CaiHachIhAH
SKTxVZzvyzYjPjjuzQPdMusCIqbEcS VZzvyzY
cRBDMpmlSsoxOmXMRffooPwMpBiyGj SsoxOmXM
kLPHzlBKBLFbBfkZYgyKaqQnwPQumk zlBKBLFbBfkZ
NIiEEBusdmDlxLcOCoXMBvyaZyoDOc dmDlxLcOCoXM
kIiIGJOMUyBnZHbcjolBXyCxLIiYbc lBXyCxLIiYbc
nnfxTdBorUByCZIXBdFJIifqkKQjOq FJIifqkKQj
alGbtXgoGvJflUGPNcJcJvPykrEdDt dD
jrjeJgkyKRhnBmlUVtiCgKgForwKGw 
umlNGkaqCsJQMCLyrgOoGOFfrCabsA gOoGOFf
zyWBmItnzDpPdfFFBshbJuxEQixsGj DpPdfFF
CSihJFISLSYyysisIlSJLdajPmstoS ISLSYyysisIlS
kAPHhpVPCvcpVatKbDTM           APHhpVPCvcpVa
UImyYBobiFfIOoFMkMWU           ImyYBobiFfIOoFM
OmRmFMhZkHofzOfKdoDF           mFMhZkHofzOfKdoDF
XuIEUUxieYqDxxbpIiJK           XuIEUUxie
XuIEUUxie                      XuIEUUxie
