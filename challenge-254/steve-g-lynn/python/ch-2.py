# python 1.4 beta on DOSBOX
# does not run in python 2.7.18

import regex,regsub,string
vowels=regex.compile("[aeiouAEIOU]")

def reverse_vowels(mystr):
 vind=[] #store indices of vowel elements of mystr
 str2arr=[] #store elements of mystr
 for i in range(len(mystr)):
  str2arr.append(mystr[i])
  if ( vowels.match( mystr[i] ) > -1 ):
   vind.append(i)
 vindr=vind[:]
 vindr.reverse()
 
 for i in range(len(vind)):
  str2arr[vind[i]]=mystr[vindr[i]]
 retval=regsub.gsub(" ","", string.join(str2arr))
 return string.capitalize(string.lower(retval))
 
print reverse_vowels("Raku") #Ruka
print reverse_vowels("Perl") #Perl
print reverse_vowels("Julia") #Jaliu
print reverse_vowels("Uiua") #Auiu
