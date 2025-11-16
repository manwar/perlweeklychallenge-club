package p1347

import "core:fmt"
import "core:strings"
import "core:slice"
import "core:strconv"


format_date ::proc(inp:^string){
    MONTHS := []string{"Jan", "Feb", "Mar", "Apr", "May","June","July","August","Sep","Oct","Nov","Dec"}
    // reverse loop for the format
    #reverse for v,i in strings.split(inp^," "){

        switch i{
            // switch indices
            case 2:   
            // sep="" for the right format
                fmt.print(v,"-",sep="")
            case 1:
            // find index and add one; if below zero add 0 in front
                ind,found:=slice.linear_search(MONTHS,v)
                if ind < 9{
                    fmt.print("0",ind+1,"-",sep="")
                }
                else{
                     fmt.print(ind+1,"-",sep="")
                }
            case 0:
                sub,_:=strings.substring(v,0,2)
                num,isnum:= strconv.parse_int(sub)
                // if first two chars are numbers, print ; else add 0 in front
                if isnum{
                    fmt.print(sub,sep="")
                }
                else{
                    sub,_:=strings.substring(v,0,1)
                    fmt.print("0",sub,sep="")
                }
                
        }
    }
}

main :: proc() {


	inpt:= []string{"1st Jan 2025","22nd Feb 2025","15th Apr 2025","23rd Oct 2025","31st Dec 2025"}

    for &i in inpt{
        format_date(&i)
        fmt.println()
    }

  

}
