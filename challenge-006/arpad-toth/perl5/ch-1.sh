#Create a script which takes a list of numbers from command line and print the same in the compact form. 
#For example, if you pass “1,2,3,4,9,10,14,15,16” then it should print the compact form like “1-4,9,10,14-16”.
#one liner, runs fine in my rhel 7.6 terminal bash shell
perl -e '@nu=split/,/,shift;$i=0;do{if($nu[$i]+1==$nu[$i+1] && $nu[$i]+2==$nu[$i+2] && $j==0){print "$nu[$i]-";$i++;$j=1}elsif($j==1 && $nu[$i]+1==$nu[$i+1]){$i++}else{print "$nu[$i],";$i++;$j=0}}while($i<=$#nu)' 1,2,3,4,9,10,14,15,16

#happy coding :-)
