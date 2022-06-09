singer(sonu).
my_append([], X, X). 
my_append([X|Xs], Ys, [X|Zs]):-
 my_append(Xs, Ys, Zs).

nrev([], []).
nrev([X|Xs], Zs):-
	nrev(Xs, Ys),
	append(Ys, [X], Zs).

rev(Xs, Zs):-
	rev(Xs, [], Zs). 

rev([], Acc, Acc). 
	rev([X|Xs], Acc, Zs):-
	rev(Xs, [X|Acc], Zs).

gtl([H|T], N) :- H > N, gtl(T, N).
gtl([]).
 
		
