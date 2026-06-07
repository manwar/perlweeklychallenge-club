
import re

## Example 1
## strInput = "you're given the job of checking the pages on a\nweb server for doubled words (such as 'this this'), a common problem\nwith documents subject to heavy editing."

## Example 2
strInput = "Find doubled words despite capitalization differences, such as with 'The\nthe...', as well as allow differing amounts of whitespace (spaces,\ntabs, newlines, and the like) to lie between the words."

## Example 3
## strInput = "to make a word bold: '...it is <B>very</B> very important...'."

## Example 4
## strInput = "Perl officially stands for Practical Extraction and Report Language, except when it doesn't."

## Example 5
## strInput = "There's more than one one way to do it.\nEasy things should be easy and hard things should be possible."


## 使用 re.sub 的回傳函數（lambda）來為前後兩個單字加上中括號
## ArgvMat.group(1) 是第一個單字，ArgvMat.group(0) 是整個匹配到的區塊
## 我們需要保留中間的 HTML 標籤或空白，所以將整個匹配區塊的前後單字替換為帶括號的版本


def FuncReplace(ArgvMat):
    objFullMatch = ArgvMat.group(0)
    objWord = ArgvMat.group(1)

    ## 找出第一個和最後一個單字的位置，並加上括號
    ## 這裡使用正則確保只替換邊界上的單字，不影響中間可能剛好同名的 HTML 屬性

    objStartWordPattern = rf"^{re.escape(objWord)}"
    objEndWordPattern = rf"{re.escape(objWord)}$"

    ## 由於忽略大小寫，替換時需保留原本的大小寫狀態
    ## 先替換結尾的單字，再替換開頭的單字
    objResult = re.sub(objStartWordPattern, f"[{objWord}]", objFullMatch, flags = re.IGNORECASE)
    objResult = re.sub(objEndWordPattern, f"[{objWord}]", objResult, flags = re.IGNORECASE)

    return objResult


def FuncHighlightDoubledWords(InputTxt):
    ## 正則表達式解析：
    ## \b([a-zA-Z0-9_]+)\b  : 匹配第一個單字並放入群組 1
    ## (?:<[^>]+>|\s)+      : 匹配夾在中間的 HTML 標籤或任意空白（可重複多次）
    ## \b\1\b               : 匹配與群組 1 完全相同的單字（使用 \1 反向參照）
    ## re.IGNORECASE        : 忽略大小寫差異

    objPattern = r"\b([a-zA-Z0-9_]+)\b(?:<[^>]+>|\s)+\b\1\b"

    ## 處理跨行文本
    objModifiedTxt = re.sub(objPattern, FuncReplace, InputTxt, flags = re.IGNORECASE)

    ## 篩選並只顯示含有加括號重複單字的行
    arrOutputLines = [strLineLoop for strLineLoop in objModifiedTxt.splitlines() if "[" in strLineLoop and "]" in strLineLoop]

    return "\\n".join(arrOutputLines)


print (FuncHighlightDoubledWords(strInput))
