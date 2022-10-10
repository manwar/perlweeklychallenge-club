
### Credit
### https://stackoverflow.com/questions/2700859/how-to-replace-unicode-characters-by-ascii-characters-in-python-perl-script-giv

import unicodedata

## strUniCode = u'ÃÊÍÒÙ'  ## Example 1
strUniCode = u'âÊíÒÙ'  ## Example 2

def GetConvUniToASC (bStrInput):

    bStrASCWord = unicodedata.normalize('NFKD', bStrInput).encode('ascii','ignore')
    strASCWord = bStrASCWord.decode("utf-8") 

    return strASCWord

print (GetConvUniToASC(strUniCode))
