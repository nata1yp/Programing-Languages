fun loop_rooms in_file = 
let
    fun parse file =
        let
            fun readInt input = 
            Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

        (* Open input file. *)
        val inStream = TextIO.openIn file

            (* Read an integer (number of countries) and consume newline. *)
        val n = readInt inStream
    val m = readInt inStream
        val _ = TextIO.inputLine inStream
    
    fun parse1 ins =
    case TextIO.inputLine inStream of
        NONE=>rev ins
        |SOME line=>parse1(explode(String.substring(line,0,m))::ins)

    val list=parse1 []
    val _ = TextIO.closeIn inStream
    in
        (n,m,Array2.fromList list)
    end


    val (rows,columns,chars) = parse in_file

    val mark_arr=Array2.array(2*rows,2*columns,0) 

    fun move (i, j, char) = case char of #"U"=>  (i-1,j)
                                        | #"D"=>  (i+1,j)
                                        | #"L"=>  (i,j-1)
                                        | #"R"=>  (i,j+1)
                                    

    fun y_lim i = if (i=rows orelse i<0) then true
                    else false;

    fun x_lim j = if (j=columns orelse j<0) then true
                    else false;
    
    fun changeto1(array,[]) = array
        |changeto1 (array, h::tl) =
            let
                val (i,j) = h
                val maze = Array2.update(array,i,j,1)    
            in
                changeto1(array, tl)
            end

    fun changeto2(array, [])= array
        |changeto2 (array, h::tl)=
            let
                val (i,j) = h
                val maze = Array2.update(array,i,j,2)
            in
                changeto2(array, tl)
            end
            
    fun num_change (array,i,j,num)= 
    let
        val maze = Array2.update(array,i,j,num)
    in
        array
    end

    fun checkpath (chars,array,visited,(i,j),counter)=
        if(y_lim i orelse x_lim j orelse Array2.sub(array,i,j) = 2) then (false,visited,array,counter)
        else 
            if Array2.sub(array,i,j) = 0 then
                let
                fun check(chars,array,visited,(i,j))=
                case Array2.sub(chars,i,j) of 
                #"U"=>checkpath(chars,num_change(array,i,j,1),(i,j)::visited,(i-1,j),counter+1)
                | #"D"=>checkpath(chars,num_change(array,i,j,1),(i,j)::visited,(i+1,j),counter+1)
                | #"R"=>checkpath(chars,num_change(array,i,j,1),(i,j)::visited,(i,j+1),counter+1)
                | #"L"=>checkpath(chars,num_change(array,i,j,1),(i,j)::visited,(i,j-1),counter+1)
                in
                check(chars,array,visited,(i,j))
                end
            else 
                (true,visited,array,counter)


    fun traverse(rows,columns,char,num)=
        let
            fun col_trav (arr, counter, n, m, i) =
                if (i = n) then counter
                            else
                                let
                                    fun assist (array,(i,j),counter) =
                                        let 
                                            val (check,visited,array1,countb)= checkpath(char,array,[],(i,j),0)
                                            
                                            fun changeto1(array,[])=array
                                            |changeto1(array, h::tl)=
                                                let 
                                                    val (i,j) = h 
                                                in 
                                                    changeto1(num_change(array,i,j,1),tl) 
                                                end

                                            fun changeto2(array,[])=array
                                            |changeto2(array, h::tl)=
                                                let 
                                                    val (i,j)=h 
                                                in 
                                                    changeto2(num_change(array,i,j,2),tl) 
                                                end
            

                                            fun r check=if check then (changeto1(array1,visited),countb+counter)
                                                        else (changeto2(array1,visited),counter)

                                            val res = r check
                                        in
                                            res
                                        end
                
                                    fun rows_trav ((array,counter), m, j)=
                                    if (j = m) then (counter,array)
                                                else rows_trav (assist(array,(i,j),counter), m, j+1)
                                    
                                    val (rows_arr,row_count) = rows_trav ((arr,counter), m, 0)
                                    
                                in
                                    col_trav (row_count, rows_arr, rows, columns, i+1)
                                end
        in
            col_trav(num, 0, rows, columns, 0)
        end 

    val result = traverse(rows, columns, chars, mark_arr)
in
    print(Int.toString result ^"\n")
end
