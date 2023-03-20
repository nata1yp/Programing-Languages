read_input(File, N, L) :-
	open(File, read, Stream),
	read_line(Stream, N),
	read_line(Stream, L).

read_line(Stream, L) :-
	read_line_to_codes(Stream, Line),
	atom_codes(Atom, Line),
	atomic_list_concat(Atoms, ' ', Atom),
	maplist(atom_number, Atoms, L).

init(L,config(L,[])).

add(H,T,[H|T]).

remove([H|T],H,T).

addendum([ ],X,[X]).
addendum([H|T],X,[H|Z]) :- addendum(T,X,Z).

move(config(Q,S),config(NQ,NS),'Q') :- 	add(H,S,NS),
					remove(Q,H,NQ).
move(config(Q,S),config(NQ,NS),'S') :-	addendum(Q,X,NQ),
					remove(S,X,NS).

set([_]).
set([X,Y|Z]) :- X=<Y, set([Y|Z]).

term(config(L,[])) :- set(L).

length([]).
length([_,_|R]) :- length(R),!.

solve([],C) :- term(C).
solve([M|Moves],C) :-	move(C, C1, M),
						solve(Moves,C1).	
solve(Moves,L,_) :-	length(Moves,_),
					init(L,IC),
					solve(Moves,IC),!.

qssort(File,Moves) :-	read_input(File,_,L),
						(set(L) -> Moves = 'empty';
						solve(M,L,_),
						atomics_to_string(M,Moves)).
