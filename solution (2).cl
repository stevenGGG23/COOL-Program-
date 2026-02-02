(*
   Name: Steven Gobran
   PROGRAM #: program1
   DUE DATE: Wednesday, 2/11/26
   INSTRUCTOR: Dr. Zhijiang Dong
   
   Program description:
   Stack machine interpreter supporting commands: int (push integer), * (push operator),
   e (evaluate - multiply top two integers if * on top), d (display stack), x (exit).
   
   Variables:
   stack - List holding stack elements as strings
   converter - A2I object for string/integer conversion
   continue - Bool controlling main program loop
*)

(* A2I class provides integer-to-string and string-to-integer conversion *)

(* c2i - Converts single character string to integer, aborts if not "0"-"9" *)
class A2I {
     c2i(char : String) : Int {
	if char = "0" then 0 else
	if char = "1" then 1 else
	if char = "2" then 2 else
        if char = "3" then 3 else
        if char = "4" then 4 else
        if char = "5" then 5 else
        if char = "6" then 6 else
        if char = "7" then 7 else
        if char = "8" then 8 else
        if char = "9" then 9 else
        { abort(); 0; }  -- the 0 is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

(* i2c - Inverse of c2i, converts integer to single character string *)
     i2c(i : Int) : String {
	if i = 0 then "0" else
	if i = 1 then "1" else
	if i = 2 then "2" else
	if i = 3 then "3" else
	if i = 4 then "4" else
	if i = 5 then "5" else
	if i = 6 then "6" else
	if i = 7 then "7" else
	if i = 8 then "8" else
	if i = 9 then "9" else
	{ abort(); ""; }  -- the "" is needed to satisfy the typchecker
        fi fi fi fi fi fi fi fi fi fi
     };

(* a2i - Converts ASCII string to integer, handles signed/unsigned strings *)
     a2i(s : String) : Int {
        if s.length() = 0 then 0 else
	if s.substr(0,1) = "-" then ~a2i_aux(s.substr(1,s.length()-1)) else
        if s.substr(0,1) = "+" then a2i_aux(s.substr(1,s.length()-1)) else
           a2i_aux(s)
        fi fi fi
     };

(* a2i_aux - Helper for a2i, converts unsigned portion iteratively *)
     a2i_aux(s : String) : Int {
	(let int : Int <- 0 in	   
           {	               
               (let j : Int <- s.length() in
	          (let i : Int <- 0 in
		    while i < j loop
			{
			    int <- int * 10 + c2i(s.substr(i,1));
			    i <- i + 1;
			}
		    pool
		  )
	       );
              int;
	    }
        )
     };

(* i2a - Converts integer to string, handles positive and negative numbers *)
    i2a(i : Int) : String {
	if i = 0 then "0" else
         if 0 < i then i2a_aux(i) else
          "-".concat(i2a_aux(i * ~1))
         fi fi
    };
	
(* i2a_aux - Helper for i2a using recursion *)
    i2a_aux(i : Int) : String {
        if i = 0 then "" else
	    (let next : Int <- i / 10 in
		i2a_aux(next).concat(i2c(i - next * 10))
	    )
        fi
    };

};


(* List class - Empty list with basic operations: isNil, head, tail, cons *)
class List {
   isNil() : Bool { true };
   head()  : String { { abort(); ""; } };
   tail()  : List { { abort(); self; } };
   cons(item : String) : List {
      (new Cons).init(item, self)
   };
};


(* Cons class - Non-empty list node with car (data) and cdr (rest of list) *)
class Cons inherits List {
   car : String;	-- data in this node
   cdr : List;		-- rest of the list

   isNil() : Bool { false };
   head()  : String { car };
   tail()  : List { cdr };

   init(i : String, rest : List) : List {
      {
	 car <- i;
	 cdr <- rest;
	 self;
      }
   };
};


(* StackCommand - Main interpreter class for stack machine operations *)
class StackCommand inherits IO {
    stack : List <- new List;        -- stack holds elements as strings
    converter : A2I <- new A2I;      -- for string/int conversion
    
    (* push - Adds item to top of stack *)
    push(item : String) : Object {
        stack <- stack.cons(item)
    };
    
    (* pop - Removes and returns top element from stack *)
    pop() : String {
        let item : String <- stack.head() in
        {
            stack <- stack.tail();
            item;
        }
    };
    
    (* display - Prints stack contents from top to bottom *)
    display() : Object {
        let temp : List <- stack in
            while not temp.isNil() loop
                {
                    out_string(temp.head());
                    out_string("\n");
                    temp <- temp.tail();
                }
            pool
    };
    
    (* evaluate - If top is "*", pops it and multiplies next two integers *)
    evaluate() : Object {
        if not stack.isNil() then
            let top : String <- stack.head() in
                if top = "*" then
                    {
                        pop();
                        let operand1 : Int <- converter.a2i(pop()) in
                        let operand2 : Int <- converter.a2i(pop()) in
                        let result : Int <- operand1 * operand2 in
                        push(converter.i2a(result));
                    }
                else
                    0
                fi
        else
            0
        fi
    };
    
    (* run - Main program loop: prompts for input and processes commands *)
    run() : Object {
        let continue : Bool <- true in
            while continue loop
                {
                    out_string(">");
                    let input : String <- in_string() in
                        if input = "d" then
                            display()
                        else if input = "e" then
                            evaluate()
                        else if input = "x" then
                            continue <- false
                        else
                            push(input)
                        fi fi fi;
                }
            pool
    };
};


(* Main - Program entry point, creates and runs StackCommand *)
class Main inherits IO {
    main() : Object {
        (new StackCommand).run()
    };
};
