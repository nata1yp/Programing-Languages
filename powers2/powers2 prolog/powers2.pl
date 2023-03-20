read_input(File, N) :-
    open(File, read, Stream),
    read_line(Stream, [N]).

read_line(Stream,L) :-
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, L).


dec2bin(0,[0]).
dec2bin(1,[1]).
dec2bin(N,L):- 
    N > 1,
    X is N mod 2,
    Y is N // 2,  
    dec2bin(Y,L1),
    L = [X|L1].

	
sumlist([],0).
sumlist([X|T],S):-
	sumlist(T,S1),
	S is S1+X.

listup2([Y|T],L):-
	Y>0,
	N is Y-1,
	L=[N|T].

listup1([X|T],L):- 
	listup2(T,L1),
	N is X+2,
	L=[N|L1].
listup1([X|T],L):-
	listup1(T,L2),
	L=[X|L2].

repeat(L,K,K,F):-
	F=L.
repeat(L,C,K,F):-
	C>K,
	F=[],!.
repeat(L,C,K,F):- 
	N is C+1,
	listup1(L,L1),
	repeat(L1,N,K,F1),
	F=F1.

clear([],_,_,L):-
	L=[],!.
clear(_,C,K,F):-
	C=:=K,
	F=[].
clear([X|T],C,K,L):-
	C<K,
	N is C+X,
	clear(T,N,K,L1),
	L=[X|L1].

break_list([X|T],N,K):-
	N is X,
	K is T.

repeatN(0,Stream,[]).
repeatN(T,Stream,Answers):-
	read_line(Stream,L),
	break_list(L,N,K),
	dec2bin(N,L1),
	sumlist(L1,S),
	repeat(L1,S,K,L2),
	clear(L2,0,K,L3),
	T1 is T-1,
	repeatN(T1, Stream,Answers1),
	Answers=[L3|Answers1].
	
powers2(File, Answers):-
	open(File, read, Stream),
    read_line(Stream, [N]),
	repeatN(N, Stream, Answers),!.




	
	

	

	
	

	