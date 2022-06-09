/************************** is_all_greater_than ************************/

%% #1 10-points
%is_all_greater_than(List, N): succeed iff all numbers in list of
%numbers List are greater than N.
%%Hint: use recursion on List.

is_all_greater_than([], _).
is_all_greater_than([H|T], N) :-
	process(H,N), is_all_greater_than(T, N).
process(H,N):-
	H > N.

/*************************** get_greater_than1 *************************/

%% #2 10-points
%get_greater_than1(List, N, M): succeed iff M matches a number in List
%which is greater than N.
%
%%get_greater_than1([],_,_).
get_greater_than1([H|T], N, M):-
	M = H, H > N;
	get_greater_than1(T, N, M). 
%Example:
% ?- get_greater_than1([2, 3, 1, 4], 2, M).
% M = 3 ;
% M = 4 ;
% false.
%
%Restriction: May not use any auxiliary procedures.
%Hint: Use separate rules for head and tail of List.

/*************************** get_greater_than2 *************************/

%% #3 10-points
%get_greater_than2(List, N, M): succeed iff M matches a number in List
%which is greater than N.  Same spec as previous exercise.
%Restriction: Must be a single rule which uses member/2.
%Hint: use generate-and-test with member/2 used to generate
%and comparison used to test.
get_greater_than2([], _, _):-
	member([],[]).
get_greater_than2([H|T], N, M):-
	(H = M, H > N); 
	get_greater_than2(T, N, M).
/************************* get_all_greater_than ************************/

%% #4 15-points
%get_all_greater_than(List, N, GreaterThanN): GreaterThanN matches
%the list of numbers from List (in order) which are greater than N.
%Restriction: May not use any auxiliary procedures.
%Hint: use a rule for empty List and two separate rules for a non-empty List.

get_all_greater_than([], _, []) :- true.
get_all_greater_than([H|T], N, GTN) :- H > N, get_all_greater_than(T, N, Return), GTN = [H|Return].
get_all_greater_than([H|T], N, GTN) :- H =< N, get_all_greater_than(T, N, Return), GTN = Return.
/*********************** get_all_greater_than_tr ***********************/
%% #5 15-points
%get_all_greater_than_tr(List, N, GreaterThanN): GreaterThanN matches
%the list of numbers from List (in order) which are greater than N.
%The procedure must be tail-recursive; i.e. the "return value" of
%any recursive calls must be the "return value" of the original call.
%Restriction: May define and use a *single* auxiliary procedure and
%either reverse/2 or append/3.
%Hint: Define an auxiliary procedure witn an extra argument which
%accumulates GreaterThanN.

helper([], _, GreaterThanN, Temp) :- GreaterThanN = Temp.
helper([H|T], N, GreaterThanN, Temp) :- H > N, helper(T, N, GreaterThanN, [H|Temp]).
helper([H|T], N, GreaterThanN, Temp) :- H =< N, helper(T, N, GreaterThanN, Temp).
get_all_greater_than_tr(List, N, GreaterThanN) :- 
	helper(List, N, GreaterThanNBackwards, []), 
	reverse(GreaterThanNBackwards, GreaterThanN).
/*************************** split_into_pairs **************************/

%% #6 10-points
%split_into_pairs(List, PairList): PairList is a list of pairs (2-element
%lists) of elements of List in order.  If List has odd length, then the
%last element of PairList will match a 1-element list containing the last
%element of List.
%Restriction: May not use any auxiliary procedures.
%Hint: consider cases of List empty, List a 1-element list and List
%containing 2-or-more elements.
split_into_pairs([], []) :- true.
split_into_pairs([Temp], [[Temp]]) :- true.
split_into_pairs([First | [Second | Tail]], PairList) :- 
	PairList = [[First, Second]|Result], split_into_pairs(Tail, Result).
/******************************** sum_areas ****************************/
%% #7 10-points
%sum_areas(Shapes, SumArea): match SumArea to the sum of the shapes in
%list Shapes.  A shape is either rect(X, Y, W, H) with area W*H or
%circ(X, Y, R) with area pi * R * R (note pi is defined on the
%RHS of is/2).
sum_areas([], 0) :- true.
sum_areas([(rect(_, _, W, H))|Tail], SumArea) :- 
	Area is W * H, sum_areas(Tail, TailAreas), 
	SumArea is Area + TailAreas.
sum_areas([(circ(_, _, R))|Tail], SumArea) :- 
	Area is pi * R * R, 
	sum_areas(Tail, TailAreas), 
	SumArea is Area + TailAreas.
/******************************* n_prefix ******************************/

%% #8 10-points
%n_prefix(N, List, Prefix, Rest): Prefix matches the N-prefix of list List
%and Rest matches the rest of the list.  It is assumed that N > 0 and
%length(List) >= N.
%Restriction: May not use any auxiliary procedures.
%Hint: Recurse on N.
n_prefix(1, [H|T], [H], Rest) :- Rest = T.
n_prefix(N, [H|T], Prefix, Rest) :- 
	Temp is N - 1, n_prefix(Temp, T, P, R), 
	Prefix = [H|P], Rest = R.
/***************************** split_into_n_lists **********************/

%% #9 10-points
%split_into_n_lists(N, List, NLists): match NLists with the N-element
%sublists of List in order.  If length(List) is not divisible by N,
%leaving some leftover elements, then the last element of NLists will
%match the leftover elements of List.  It is assumed that N > 0.
%Hint: List is either empty or non-empty.  If non-empty, its
%length is < N, or its length is >= N; in the latter case, use n_prefix/3
%to recurse.
accumulate(_, [], Return, Accumulator) :- Return = Accumulator.
accumulate(N, List, Return, Accumulator) :- 
	length(List, Len), 
	Len =< N, 
	Return = [List|Accumulator].
accumulate(N, List, Return, Accumulator) :- length(List, Len), Len > N,
	n_prefix(N, List, Head, Tail), 
	accumulate(N, Tail, Return, 
	[Head|Accumulator]).
split_into_n_lists(N, List, NLists) :- 
	accumulate(N, List, Return, []), 
	reverse(NLists, Return).
