class charley{
    func oi(sup){
        return cat(self.name," sup ",sup)
    }
    self.name = "charles"
    self.age = 34
}
func a(something){
    return b(something)
}
func b(cstr){
    return c(cat("a:from:b=",cstr))
}
func c(cstr){
    return cat("fin=",cstr)
}
func m(iets){
    return iets
    }
timer = timerinit()
xa = "a"
b = 0
for x to 50000{
    split("1234567890","")
    split("1234567890","")
    split("1234567890","")
    split("1234567890","")
    cat("a","b")
    cat("a","b")
    cat("a","b")
    cat("a","b")
    cat("a","b")
}
//xa = split(xa,"|")
//xa = cat[] xa cat("-->",x)
//print(xa[930],"g")
if x == 50000{
        print("[Test1] Passed!","g")
    }
    else{
        print("[Test1] failed!","r")
}
print(cat("test1: 50k block8calls:", timerdiff(timer)),"b")
timer = timerinit()
xa = "a"
b = 0

for x to 50000{
    if 1 == 1 {
        if 2 == 2 {
            if 3 == 3 {
                if 4 == 4 {
                    b ++
                    xa = cat("res:",b)
                }
            }
        }
    }
}

//xa = cat[] xa cat("-->",x)
//print(xa,"bg")
//print(b,"bg")

if xa == "res:50001"{
        print("[Test1b] Passed!","g")
    }
    else{
        print("[Test1b] failed!","r")
}
print(cat("test1b: 50k 5nests : ",timerdiff(timer)),"b")
d = ""
timer = timerinit()
    d = string x to 50000{
        x
    }
    // print(d,"brown")
    s = split(d,"")
    if len(s) == 238897 {
        print("[Test2] Passed!","g")
    }
    else{
        print("[Test2] failed!","r")
    }
    print(cat("test2 50k stringcat-grow:",timerdiff(timer)),"b")

timer = timerinit()
for x to 50000{
    ma = math 246 + 12312 - 44 * 2 / 2 + 24 / 4 + 33 * 1.5
}
//print(ma,"g")
if ma == 4751.25{
        print("[Test3] Passed!","g")
    }
    else{
        print("[Test3] failed!","r")
}
print(cat("test3 50k math ops:",timerdiff(timer)),"b")
//print("test4","y") !
timer = timerinit()
for x to 50000{
    ma = a(x)
}
//print(ma,"g") fin=a:from:b=50000
if ma == "fin=a:from:b=50000"{
        print("[Test4] Passed!","g")
    }
    else{
        print("[Test4] failed!","r")
}
print(cat("test4 50k funcwithfunccalls:",timerdiff(timer)),"b")
timer = timerinit()
for x to 10000{
    ma = cat "obj" x
    *ma : charley
}


//print(ma,"g")
if obj4563.oi("jaja") == "charles sup jaja"{
        print("[Test5] Passed!","g")
    }
    else{
        print("[Test5] failed!","r")
}
print(cat("test5: 10k object spawning:",timerdiff(timer)),"b")
timer = timerinit()

thisvec = vec x to 1000000{
    x
}
//print(thisvec[5900],"orange")
if 5900 == thisvec[5900]{
        print("[Test6] Passed!","g")
    }
    else{
        print("[Test6] failed!","r")
}
print(cat("test6: 1M vecsetcounter:",timerdiff(timer)),"b")
// print(thisvec[5900],"bb")
// if x == thisvec[5900]{
//         print("[Test6] Passed!","g")
//     }
//     else{
//         print("[Test6] failed!","r")
// }
timer = timerinit()
loop {
match i {
    1 2 3 4 5 =>{
        cat("oi-",i)
    }
    600 7000 8000 =>{
        cat("oi-",i)
    }
}

    i ++
    if i > 10000{
        break
    }
}
if cat("c=",c("kaaaaaaaaaaaaaaaaaaaaaaas")) == "c=fin=kaaaaaaaaaaaaaaaaaaaaaaas"{
        print("[Test7] Passed!","g")
    }
    else{
        print("[Test7] failed!","r")
}
print(cat("test7: 10k match:",timerdiff(timer)),"b")
res = cat("c=",c("kaaaaaaaaaaaaaaaaaaaaaaas"))
func tester(x){
    return cat("got",x," with version:aa")
}

timer = timerinit()
print("Starting test (scriptspersecond), please wait 7s","bg")
i = 0
di = 0
tocheck = 9
loop {
    if di > tocheck {
        tester(i)
        di = 0
    }
    else{
        d = "well"
        di ++
    }
    if timerdiff(timer) > 6999{
        break
    }
    i ++
}
result = math i / 7
print(cat("Scripts ran ",i," result per second = ",result),"g")
