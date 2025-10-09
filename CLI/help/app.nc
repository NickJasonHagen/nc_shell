if $cmdarg2 == "raw"{
            scructs = nscript::getruststructs()
        functions = nscript::getrustfunctions()
        explanation = nscript::getrustfunctionshelp()
        max = len(functions) - 1
        outputstring = ""
        for x to max{
            print(functions[x],"g")
           outputstring &= print(cat(functions[x],"",explanation[x]),"bb") @lf
        }
        filewrite("./output.txt",outputstring)
        printraw("rust::structs","bb")
        print(join(scructs,@lf))
}
else{
    scructs = nscript::getruststructs()
    functions = nscript::getrustfunctions()
    explanation = nscript::getrustfunctionshelp()
    max = len(functions) - 1
    stringvec = ""
    for x to max{
        stringvec &= cat(" corefunc ",functions[x],"",explanation[x],@lf)
    }
    words = split(stringvec," ")
    doing = "func"
    xid = 0
    for xword in words{
        if xword == "corefunc"{
            doing = "func"
            printraw(cat("fn-id:",xid," | "),"p")
            xid ++
        }
        if xword == "//"{
            doing = "comment"
        }
        if xword != "corefunc" {
            if doing = "func"{
                if instring(xword,"(") == true{
                    splitf = split(xword,"(")
                    printraw(splitf[0],"bb")
                    printraw("(","by")
                    argsplit = split(splitselect(splitf[1],")",0),",")
                    i = 0
                    max = len(argsplit)
                    for xarg in argsplit{
                        i ++
                        printraw(xarg,"p") 
                        if i < max {
                            printraw(",","by")
                        }
                    }
                    printraw(")","by")
                }
            }
            else{
                printraw(xword,"g")
            }
        }
        printraw(" ")
    }
    print("--struct based --")
    print("custom rust::structs imported","bb")
    print(join(scructs,@lf),"br")
}
