class charley{
    func oi(sup){
        print(cat(self.name," sup ",sup))
        "charreles"
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

print(cat("test1: 50k block8calls:", timerdiff(timer)),"r")
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
print(cat("test1b: 50k 5nests : ",timerdiff(timer)),"r")
d = ""
timer = timerinit()
    d = string x to 50000{
        x
    }
    s = split(d,"")
    print(cat("stringlen:",len(s)),"bb")
diff = timerdiff(timer)
print(cat("test2 50k stringcat-grow:",diff),"r")

timer = timerinit()
for x to 50000{
    ma = math 246 + 12312 - 44 * 2 / 2 + 24 / 4 + 33 * 1.5
}
print(ma,"g")
print(cat("test3 50k math ops:",timerdiff(timer)),"r")
//print("test4","y") !
timer = timerinit()
for x to 50000{
    ma = a(x)
}
print(ma,"g")
print(cat("test4 50k funcwithfunccalls:",timerdiff(timer)),"r")
timer = timerinit()
for x to 10000{
    ma = cat "obj" x
    *ma : charley
}
obj4563.oi("jaja")

print(ma,"g")
print(cat("test5: 10k object spawning:",timerdiff(timer)),"r")
timer = timerinit()

thisvec = vec x to 1000000{
    x
}

print(cat("test6: 1M vecsetcounter:",timerdiff(timer)),"r")
print(thisvec[5900],"bb")

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

print(cat("test7: 10k match:",timerdiff(timer)),"r")
print(cat("c=",c("kaaaaaaaaaaaaaaaaaaaaaaas")),"b")
