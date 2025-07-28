/ check if element of vector is divisible by 2
odd: {0=2!+/x=inp}
/ looking for character x in word inp; inp is set as global variable
{inp::x ; $[0=(+/{odd x}'x);"true";"false" ]}'("weekly";"perl";"challenge")
