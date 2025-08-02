
## Remarks
## https://stackoverflow.com/questions/74569246/replace-space-in-between-double-quote-to-underscore

import json
import re

def GetDoubleQuote (strInput):
    if strInput[0] == "\"":
        return strInput
    return "\"" + strInput + "\""

def repl(strInput):
    return strInput[0].replace(' ', '^')


## strLineInput = '{%  id   field1="value1"    field2="value2"  field3=42 %}'  ## Example 1
## strLineInput = '{%  youtube title="Title \"quoted\" done" %}'  ## Example 2
## strLineInput = '{%  youtube title="Title quoted done" %}'  ## Example 3
## strLineInput = '{%  youtube title="Title with escaped backslash \\" %}'  ## Example 4
## strLineInput = '{%  id   %}'  ## Example 5
strLineInput = '''
{%  id   field1="value1"    field2="value2"  field3=42 %}
LINES
{% endid %}
'''  ## Example 6

bMultipleLine = False
arrMultipleLineSplit = strLineInput.split("\n")

if len(arrMultipleLineSplit) > 1:
    bMultipleLine = True
    strLineInput = arrMultipleLineSplit[1]

strReplacePattern = re.compile(r'\"[^\"]+\"')
strLineInput = re.sub(strReplacePattern, repl, strLineInput)

arrLineSplit = strLineInput.replace("%", "").split()
arrLineSplit = [elemLoop.replace('^', ' ') for elemLoop in arrLineSplit]

arrLineSplit[1] = GetDoubleQuote("name") + " : " + GetDoubleQuote(arrLineSplit[1])
for nIndx in range(2, len(arrLineSplit) - 1):
    arrLineSplit[nIndx] = " : ".join([GetDoubleQuote(elemLoop) if nIndx == 0 else elemLoop for nIndx, elemLoop in enumerate(arrLineSplit[nIndx].split("="))])

strJsonOutput = "{" + arrLineSplit[1]
if len(arrLineSplit) > 3:
    strJsonOutput = strJsonOutput + ", " + GetDoubleQuote("fields") + " : " + "{" + ", ".join(arrLineSplit[2:-1]) + "}"

if bMultipleLine:
    strJsonOutput = strJsonOutput + ", " + GetDoubleQuote("text") + " : " + GetDoubleQuote(arrMultipleLineSplit[2])

strJsonOutput = strJsonOutput + "}"

## print (arrLineSplit)
## print (strJsonOutput)
print (json.loads(strJsonOutput))
## print (json.loads(strJsonOutput)["name"])
