#!/usr/bin/env scala                                                                                                                                                                          
println( "Input: " + args.toList )  // input from command line arguments
println( "Output: " + args.toList.filter( "(?i)([qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)".r matches _ ) )

// chmod +x ch-1.sh
// ./ch-1.sh Hello Alaska Dad Peace
// Input: List(Hello, Alaska, Dad, Peace)
// Output: List(Alaska, Dad)
