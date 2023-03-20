fun longest file=
let
    fun parse file =
    let
        fun readInt input = 
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

	(* Open input file. *)
    	val inStream = TextIO.openIn file

        (* Read an integer (number of countries) and consume newline. *)
	val m = readInt inStream
    val hos= readInt inStream
	val _ = TextIO.inputLine inStream

        (* A function to read N integers from the open file. *)
	fun readInts 0 acc = acc (* Replace with 'rev acc' for proper order. *)
	  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
     
    val list = readInts m []
    in
   	(m,hos,list)
    end


fun modifyarr (n, nil) = []
	|modifyarr (n, [h]) = [~h-n]
	|modifyarr (n, h::tl) = (~h-n::modifyarr(n, tl));


fun calcprefix (s, nil) = []
    |calcprefix (s, [h]) = [s+h]
    |calcprefix (s, h::tl) = (s+h::calcprefix(s+h, tl));

fun maxmax (x,y,z)=
    let
    fun max (x,y)=if (x>y) then x
                            else y
    in
        max(x,max(y,z))
    end

fun min(lmin, nil, minim) = lmin
    |min(lmin, h::tl, minim) = if (h < minim) then min(h::lmin, tl, h) else min(minim::lmin, tl, minim);


fun max(lmax, nil, maxim) = lmax
    |max(lmax, h::tl, maxim) = if (h > maxim) then max(h::lmax, tl, h) else max(maxim::lmax, tl, maxim);

fun reverse(list) = List.rev list

fun check(r,count,[])=r
    |check(r,count,h::tl)=if (h>=0) then check(count+1,count+1,tl)
                                         else check(r,count+1,tl)

fun merge (min::mintl, max::maxtl, m, i, j, dif) = 
    if (j<m-1 andalso i<m) then 
        let 
            fun maxim (a, b) = if a>b then a else b;
            fun add(a, b, i, j, mintl, maxtl) = if a<b then (a::mintl, maxtl,i,j+1) else (mintl,b::maxtl, i+1, j)
            val (lmin,lmax,x,y) = add(min, max, i, j, mintl, maxtl)
            val sub = y-x;
        in 
            merge(lmin,lmax,m,x,y,maxim(sub,dif))            
        end
    else 
        dif;

fun solve(m,hos,list) = 
    let
        val modiarr = modifyarr(hos,list)
        val revmodiarr = reverse(modiarr)
        val sufsums = calcprefix(0, modiarr)
        val sums = calcprefix(0, revmodiarr)
        val first = hd sums
        val revsums = reverse(sums)
        val last = hd revsums
        val maximum = max([],revsums, last)
        val minimum = reverse(min([], sums, first))
        
        val check0=check(0,0,sums)
        val checkm=check(0,0,sufsums)
        val maxdiff = maxmax(check0, checkm,merge(minimum, maximum, m, 1, 0, ~1))
    in
        maxdiff
    end
    val r = solve(parse file)
in
    print (Int.toString r ^ "\n")
end
