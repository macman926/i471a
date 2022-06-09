lab6-sol().
lab6-sol():-
f(1, 2, z) = f(_, _, X),
head(a, tail(z,B), Y) = head(_ , tail(X,_), _),
cons(a, cons(b, cons(c,z))) = cons(_, cons(_, cons(_,X))),
[H|[T|TT]] = [1,2,3,4],
[H|[T1|[T2|T3]]] = [1,2,3,4],
[H|[T1|T2]] = [[1, 2], 3, 4].

