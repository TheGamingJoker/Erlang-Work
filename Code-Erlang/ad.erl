% Name: AD

-module(ad).
-compile(export_all).

% Task 1
-type atoms() :: string().
-type int() :: integer().
-type threshold() :: integer().

-type bid_list() :: list({atoms(), int()}).

-spec bid() ->  bid_list().
-spec bids() -> bid_list().
%Original Bids, Without Negatives Removed.
bid() -> [{joe, 1000}, {robert, 3000}, {grace, 5000}, {ada, 500}, {aum, -369}].

%Bids with only Positive Values
bids() -> pos_bids(bid()).
%Threshold to change when need be.
threshold() -> 8000.

% Task 1a)
pos_bids([]) -> [];
pos_bids([{X, Y} | Xs]) when Y >= 0 -> 
    [{X, Y} | pos_bids(Xs)];
pos_bids([_| Xs]) -> 
    pos_bids(Xs).

% Task 1b)
sum_bids([]) -> 0;
sum_bids([{X, Y} | Xs]) -> 
    Y + sum_bids(Xs).

success(Bids, Threshold) ->
    case(sum_bids(Bids) >= Threshold) of
        false -> false;
        true -> true
    end.

% Task 1c)
bidCheck([], Threshold) -> [];
bidCheck([{X, Y}|Xs], Threshold) when Threshold - Y > 0 -> 
    [{X,Y}| bidCheck(Xs, Threshold-Y)];
bidCheck([{X, Y}|_Xs], Threshold) when Threshold - Y =< 0 -> 
    [{X,Threshold}].

winners([], Threshold) -> [];
winners(Bids, Threshold) -> 
    bidCheck(pos_bids(Bids), Threshold).

% Task 2

% Task 2a)
init(StringOne, StringTwo) ->
    One = lists:sublist(StringOne, 1, string:length(StringOne)),
    Two = lists:sublist(StringTwo, 1, string:length(StringOne)),
    case(One == Two) of
        false -> false;
        true -> true
    end.

% Task 2b)
drop(N, St) ->
    case(N >= string:length(St)) of
        true -> "";
        false -> String = lists:split(N, St), element(2, String)
    end.

% Task 2c)
subst(Old, New, St) -> 
    case(string:str(St, Old) > 0) of
        true -> Okay =lists:flatten(string:replace(St, Old, New)),
        Okay;
        false -> St
    end.

% Task 2d)
subst2(_,_,[]) -> [];
subst2(Old, New, [X | Xs]) ->
    String = init(Old, [X | Xs]),
    case String of
      true ->
      New ++ subst2(Old, New, drop(length(Old), [X | Xs]));
      _ -> [X | subst2(Old, New, Xs)]
    end.

% Task 3

% Task 3a)
isxwin([A,B,C]) ->
    case((A == x) and (A == B) and (B == C)) of
        true -> true;
        false -> false
    end.

% Task 3b)
linexwin([X,Y,Z],[A,B,C],[L,M,N]) -> 
    case(isxwin([X,Y,Z]) == true) of
        true -> true;
        false -> case(isxwin([A,B,C]) == true) of
            true -> true;
            false -> case(isxwin([L,M,N]) == true) of
                true -> true;
                false -> false
            end
        end
    end.

% Task 3c)
pick(N, [X|Xs]) when N == 0 ->
    X;
pick(N, [X|Xs]) when N > 0 ->
    pick(N-1, Xs).


% Task 3d)
wincol([X,_,_],[X,_,_],[X,_,_]) -> true;
wincol([_,X,_],[_,X,_],[_,X,_]) -> true;
wincol([_,_,X],[_,_,X],[_,_,X]) -> true;
wincol([_,_,_],[_,_,_],[_,_,_]) -> false.
