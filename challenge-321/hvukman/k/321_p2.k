// hacky solution with globals
"part 2"
str1:"ab#c"
str2:"ad#c"
dummy1::""
dummy2::""
nooutput:{{$["#"=x;dummy1::|1_|dummy1;dummy1::dummy1,x]}x}'str1
nooutput:{{$["#"=x;dummy2::|1_|dummy2;dummy2::dummy2,x]}x}'str2
dummy1
dummy2
$[*/dummy1=dummy2;"true";"false"]
str1:"ab##"
str2:"a#b#"
dummy1::""
dummy2::""
nooutput:{{$["#"=x;dummy1::|1_|dummy1;dummy1::dummy1,x]}x}'str1
nooutput:{{$["#"=x;dummy2::|1_|dummy2;dummy2::dummy2,x]}x}'str2
dummy1
dummy2
$[*/dummy1=dummy2;"true";"false"]
str1:"a#b"
str2:"c"
dummy1::""
dummy2::""
nooutput:{{$["#"=x;dummy1::|1_|dummy1;dummy1::dummy1,x]}x}'str1
nooutput:{{$["#"=x;dummy2::|1_|dummy2;dummy2::dummy2,x]}x}'str2
dummy1
dummy2
$[*/dummy1=dummy2;"true";"false"]


