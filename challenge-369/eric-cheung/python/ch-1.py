
## strCaption = "Cooking with 5 ingredients!"  ## Example 1
## strCaption = "the-last-of-the-mohicans"  ## Example 2
## strCaption = "  extra spaces here"  ## Example 3
## strCaption = "iPhone 15 Pro Max Review"  ## Example 4
strCaption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"  ## Example 5

arrCaption = ["".join([charLoop for charLoop in list(strLoop) if charLoop.isalpha()]) for strLoop in strCaption.strip().split(" ")]

strOutput = "#" + "".join([strLoop.lower() if nIndx == 0 else strLoop.title() for nIndx, strLoop in enumerate(arrCaption)])[:99]

print (strOutput)
