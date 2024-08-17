
def round(dInput):
    return int(dInput) + (1 if dInput - int(dInput) >= 0.5 else 0)

## Example 1
strInput = "perl"
strChar = "e"

## Example 2
## strInput = "java"
## strChar = "a"

## Example 3
## strInput = "python"
## strChar = "m"

## Example 4
## strInput = "ada"
## strChar = "a"

## Example 5
## strInput = "ballerina"
## strChar = "l"

## Example 6
## strInput = "analitik"
## strChar = "k"

nPercent = round(strInput.count(strChar) * 100 / len(strInput))

print (nPercent)
