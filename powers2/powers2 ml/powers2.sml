fun parse file =
			let
				(* A function to read an integer from specified input. *)
				fun readInt input = 
				Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

				(* Open input file. *)
				val inStream = TextIO.openIn file

				(* Read an integer and consume newline. *)
				val n = readInt inStream
				val _ = TextIO.inputLine inStream

				(* A function to read N integers from the open file. *)
				fun readInts 0 acc = rev acc (* Replace with 'rev acc' for proper order. *)
													| readInts i acc = readInts (i - 1) (readInt inStream :: acc)
			in
				(n, readInts (2*n) [])
			end



fun powers (n,k) = 
	let
		fun binary n = if (n<2) then [n] 
			else (n mod 2) :: (binary(n div 2));


		fun sum n = foldr (op +) 0 (binary n);	

		fun update nil = []
		|update [a] = []
		|update (a::b::cs) = if (b=0) then a::update(b::cs)
			else (a+2) :: (b-1):: cs;
										
		fun repeat (l, counter, k) = if counter = k then l
			else 	if counter>k then []
				else repeat(update(l), counter+1, k);
	in 
	
		repeat ( binary n , sum n , k)
	end

fun powers2 file =
	let 
				
		val (x,y) = parse file															
		fun printList xs =  print("[" ^ String.concatWith "," (map Int.toString xs) ^ "]\n");				
		fun write n nil = ()
		|write n [a] = () 
		|write n (a::b::cs) = 
			if n > 0 then (printList(powers (a,b)); write (n-1) (cs) )
			else () 	
							
	in
		write x y
	end 								
					


					