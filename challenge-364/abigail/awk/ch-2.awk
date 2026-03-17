#!/opt/homebrew/bin/awk


    {
        gsub (/\(\)/,   "o");
        gsub (/\(al\)/, "al"); 
        print;
    }
