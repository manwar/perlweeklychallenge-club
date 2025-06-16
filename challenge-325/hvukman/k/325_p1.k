split: {(&~=':x)_x}
containsone: {(+/&"1"=x)>0}

bin: 0 1 1 0 1 1 1
strbin: ,//$'bin
newbin: split strbin
sol:$[(+/(containsone'newbin))=0N;0N; (|<newbin@&(containsone'newbin))[0]]
$[sol=0N;0N;#(newbin@&(containsone'newbin))[sol]]


bin: 0 0 0 0
strbin: ,//$'bin
newbin: split strbin
sol:$[(+/(containsone'newbin))=0N;0N; (|<newbin@&(containsone'newbin))[0]]
$[sol=0N;0N;#(newbin@&(containsone'newbin))[sol]]

bin: 1 0 1 0 1 1
strbin: ,//$'bin
newbin: split strbin
sol:$[(+/(containsone'newbin))=0N;0N; (|<newbin@&(containsone'newbin))[0]]
$[sol=0N;0N;#(newbin@&(containsone'newbin))[sol]]
