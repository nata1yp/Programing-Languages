read_input(File, M, N, D) :-
    open(File, read, Stream),
    read_line(Stream, [M, N]),
    read_line(Stream, D).

read_line(Stream,L) :- read_line_to_codes(Stream, Line),
                    atom_codes(Atom, Line),
                    atomic_list_concat(Atoms, ' ', Atom),
                    maplist(atom_number, Atoms, L).

head([H|_],H).

minimum(Lmin, [], _, Lmin).
minimum(Lmin, [H|T], Minim, L) :- Temp is min(Minim, H), 
                                append([Temp],Lmin,Lmin1), 
                                minimum(Lmin1, T, Temp, L). 

maximum(Lmax, [], _, Lmax).
maximum(Lmax, [H|T], Maxim, L) :- Temp is max(Maxim, H), 
                                append([Temp],Lmax,Lmax1), 
                                maximum(Lmax1, T, Temp, L). 
modifyarr(_, [], L, L).
modifyarr(N, [H|T], L, Y) :- Temp is -H-N, 
                        append([Temp],L, List),
                        modifyarr(N, T, List, Y).    

calcprefix(_, [], L, L).
calcprefix(S, [H|T], L, Y) :- Temp is S+H,
                              append([Temp],L,List),
                              calcprefix(Temp, T, List, Y).


check(R,_,[],R).
check(R, Count, [H|T], X):- H>=0 -> Temp is Count+1, check(Temp, Temp, T, X); 
                            Temp is Count+1, check(R, Temp, T, X).


next(I,J,[Hl|Tl],[Hr|Tr],L,R,Inew,Jnew):- 
                    Hl < Hr -> Inew is I, Jnew is J+1, L= [Hl|Tl], R= Tr;
                    Inew is I+1, Jnew is J, L= Tl, R= [Hr|Tr].


find([],_,R,R).
find([H|T],COUNT,R,Y):- H>0->X is COUNT+1,
                        find(T,X,X,Y);
                        X is COUNT+1,find(T,X,R,Y).


merge(N,I,J,[HMIN|TMIN],[HMAX|TMAX],TEMPMAX,Y):-I<N,J<N-1->
                                        next(I, J , [HMIN|TMIN],[HMAX|TMAX],L,R,I1,J1),
                                        SUB is J1-I1,
                                        MXM is max(TEMPMAX,SUB),
                                        merge(N,I1,J1,L,R,MXM,Y);
                                        Y = TEMPMAX.

longest(File, Answer):-
    read_input(File, M, N, D),
    modifyarr(N,D,[],LM),
    reverse(LM, LMR),
    calcprefix(0,LMR,[],SUFSUMS),
    reverse(SUFSUMS,RSUFSUMS),
    head(RSUFSUMS, First),
    head(SUFSUMS, Last),
    maximum([],SUFSUMS, Last, LMAX),
    minimum([],RSUFSUMS, First, RLMIN),
    reverse(RLMIN,LMIN),
    find(RSUFSUMS,0,0,CHECK0),
    merge(M,0,0,LMIN, LMAX, 0,DIF),
    DIF1 is DIF-1,
    Answer is max(CHECK0, DIF1).
    

