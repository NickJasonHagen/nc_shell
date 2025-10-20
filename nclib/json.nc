class json{
    func json_set(prop,data){
        jsonobj = cat "json_obj_" self
        *jsonobj.*prop = data
    }
    func json_get(prop){
        jsonobj = cat "json_obj_" self
        return *jsonobj.*prop
    }
    func json_remove(prop){
        object::deleteproperty(cat("json_obj_",self),prop)
    }
    func json_from_string(string){
        object::fromjson(cat("json_obj_",self),string)
    }
    func json_index(){
        return object::index(cat("json_obj_",self))
    }
    func json_clear(){
        object::delete(cat("json_obj_",self))
    }
    func json_to_string(){
        return object::tojson(cat("json_obj_",self))
    }

}
//iets : json
//iets.json_set("aap","mooi!").json_remove("aap").json_set("kont","ook mooi!").json_set("ja joh","oke dan!!!!")
//iets.json_get("kont") !
//print(iets.json_to_string(),"bp")