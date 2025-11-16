package p2347

import "core:fmt"
import "core:strings"


remove :: proc(str,rem:string)->string{
    // remove the rem string from str; return str_
    str_,_:=strings.remove_all(str,rem)
    return str_
}


format_phone::proc(inpt:string){
        ind:=0
        // look for length of inpt and print "-" at the right place
        for v,i in inpt{
            
            fmt.print(v,sep="")
            ind = ind+1
            if len(inpt)%4==0 && len(inpt)>4
            {
                if ind==3&&i!=len(inpt)-1
                {
                fmt.print("-",sep="")
                ind=0
                }
            }
            else if len(inpt)%3==0
            {
                if ind==3&&i!=len(inpt)-1
                {
                fmt.print("-",sep="")
                ind=0
                }
            }
            else if len(inpt)%2==0
            {
                if ind==2&&i!=len(inpt)-1
                {
                fmt.print("-",sep="")
                ind=0
                }
            }else{
                // 4th case only
                if ind==3&&i!=len(inpt)-1&&len(inpt)-i>=4{
                fmt.print("-",sep="")
                ind=0
                }
                else if ind==2&&i!=len(inpt)-1&&len(inpt)-i==3{
                    fmt.print("-",sep="")
                    ind=0
                }
            }
            
            
        }
    
   
}

main ::proc(){

    removed:= []string{"-"," "} 

    inputs:= []string{"1-23-45-6","12 34","12 345-6789","123 4567","123 456-78"} 

    for i in inputs{
         i:=i
         for j in removed
         {
            i= remove(i,j)
         }
          format_phone(i)
          fmt.println(" ")
    }
   
}
