
# 32 "unique.nw"
type t =
    { counter:              int
    ; mutable func:         int
    ; mutable variable:     int
    ; mutable parameter:    int
    ; mutable type_tag:     int
    ; mutable typedef:      int
    }

let digit i =
    assert (0 <= i && i <= 25);
    Char.chr (Char.code 'a' + i) 

let alpha i = 
    let base = 26 in
    let rec loop acc i = 
        let head, d = i / base, i mod base in
        let acc     = digit d :: acc in
        if head = 0 then acc else loop acc head
    in    
    let chars = loop [] i in
    let buf   = Buffer.create 5 in (* grows as needed *)
    let ()    = List.iter (fun c -> Buffer.add_char buf c) chars in
        Buffer.contents buf
        

let make =
    let counter  = ref 0 in
    fun () -> 
        counter := !counter + 1;
        { counter       = !counter
        ; func          = -1
        ; variable      = -1
        ; parameter     = -1
        ; type_tag      = -1
        ; typedef       = -1
        }

let func t str =
    t.func <- t.func + 1;
    Printf.sprintf "%s_%s%df" str (alpha t.counter) t.func 

let variable t =
    t.variable <- t.variable + 1;
    Printf.sprintf "%s%d" (alpha t.counter) t.variable 

let parameter t =
    t.parameter <- t.parameter +1;
    Printf.sprintf "%sp%d" (alpha t.counter) t.parameter 
    
let type_tag t =
    t.type_tag <- t.type_tag +1;
    Printf.sprintf "%st%d" (alpha t.counter) t.type_tag 

let typedef t =
    t.typedef <- t.typedef +1;
    Printf.sprintf "%sd%d" (alpha t.counter) t.typedef 

