#!/opt/homebrew/bin/gawk

{
    match ($0,
          /(-?[0-9]+)[ +()i]+(-?[0-9]+)[ +()i]+(-?[0-9]+)[ +()i]+(-?[0-9]+)/,
          parts)
    r  = parts [1] * parts [3] - parts [2] * parts [4]
    i  = parts [1] * parts [4] + parts [2] * parts [3]
    ft = i < 0 ? "%d+(%d)i\n" : "%d+%di\n"
    printf ft, r, i
}
