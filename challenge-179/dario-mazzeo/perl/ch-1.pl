# THE WEEKLY CHALLENGE - 179
# Task 1: Ordinal Number Spelling
# Autore: Dario Mazzeo

my $n=$ARGV[0];
print NumeroInTesto($n);
exit;


sub NumeroInTesto{
	my $n=$_[0];
	
	if (length($n)==1){
		if ($n==0){return "";}
		elsif ($n==1){return "uno";}
		elsif ($n==2){return "due";}
		elsif ($n==3){return "tre";}
		elsif ($n==4){return "quattro";}
		elsif ($n==5){return "cinque";}
		elsif ($n==6){return "sei";}
		elsif ($n==7){return "sette";}
		elsif ($n==8){return "otto";}
		elsif ($n==9){return "nove";}
	}
	elsif (length($n)==2){
		if ($n==10){return "dieci";}
		elsif ($n==11){return "undici";}
		elsif ($n==12){return "dodici";}
		elsif ($n==13){return "tredici";}
		elsif ($n==14){return "quattordici";}
		elsif ($n==15){return "quindici";}
		elsif ($n==16){return "sedici";}
		elsif ($n==17){return "diciassette";}
		elsif ($n==18){return "diciotto";}
		elsif ($n==19){return "diciannove";}
		
		my $n1=substr($n,0,1);
		my $str="";
		if ($n1==2){$str="venti";}
		elsif ($n1==3){$str="trenta";}
		elsif ($n1==4){$str="quaranta";}
		elsif ($n1==5){$str="cinquanta";}
		elsif ($n1==6){$str="sessanta";}
		elsif ($n1==7){$str="settanta";}
		elsif ($n1==8){$str="ottanta";}
		elsif ($n1==9){$str="novanta";}
		
		my $str=$str.(NumeroInTesto(substr($n,1,1)));
		$str=~s/[ia]([uo])/$1/;
		return $str;
	}
}