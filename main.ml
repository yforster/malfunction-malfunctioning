open Printf

let rec print_obj x = 
  let x = Obj.magic x in
  if Obj.is_block x then let size = Obj.size x in
                           if Obj.tag x = 247 then
                              Printf.printf "POINTER%!"
                           else
                           (Printf.printf ("(block[%i] (tag %i) %!") (Obj.size x) (Obj.tag x) ;
                           for i = 0 to size - 1 do
                             print_obj (Obj.field x i)
                           done;
                           Printf.printf ")")
  else  Printf.printf ("%i %!") x

let rec print_obj' x = 
  let x = Obj.magic x in
  if Obj.is_block x then for i = 0 to Obj.size x - 1 do
                             print_obj' (Obj.field x i)
                           done
  else  Printf.printf ("%c%!") x

let main =
  let x = Test_bytestring.test_bytestring () in
  Printf.printf "Malfunction result: ";
  print_obj (Obj.magic x) ;
  Printf.printf "\n";
  Printf.printf "Malfunction result, printed as string: ";
  print_obj' (Obj.magic x) ;
  Printf.printf "\n";
  Printf.printf "interpreted by OCaml as: ";
  match x with
  | Eq -> Printf.printf "Eq\n%!"
  | Lt -> Printf.printf "Lt\n%!"
  | Gt -> Printf.printf "Gt\n%!"
