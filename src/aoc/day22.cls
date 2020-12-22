Class aoc.day22 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day22test.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, j, value, player, ind1, ind2, card1, card2, cardQuantity

/// part1
/// parse file to player(1) and player(2) decks
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set value=@arrRef@(i)
    . if value="" quit
    . if value'=+value if $INCREMENT(jj) set cardQuantity=0 quit
    . set player(jj)=$INCREMENT(cardQuantity)
    . set player(jj,cardQuantity)=value

    //do ##class(aoc.file).printArr($NAME(player)) 
    //quit

    new decksInitial
    merge decksInitial=player

/// game rounds
    for  set ind1=$ORDER(player(1,"")), ind2=$ORDER(player(2,"")) quit:ind1=""!(ind2="")  do
    . set card1=$GET(player(1,ind1))
    . set card2=$GET(player(2,ind2))
    . if card1>card2 do  quit
    .. set player(1,$ORDER(player(1,""),-1)+1)=card1 
    .. set player(1,$ORDER(player(1,""),-1)+1)=card2 
    .. kill player(1,ind1), player(2,ind2)
    . if card2>card1 do  quit
    .. set player(2,$ORDER(player(2,""),-1)+1)=card2
    .. set player(2,$ORDER(player(2,""),-1)+1)=card1 
    .. kill player(1,ind1), player(2,ind2)

    new winner, jj, result

    set result=0 set jj=0
    set winner=$ORDER(player(""))

    for  set i=$ORDER(player(winner,i),-1) quit:i=""  do
    . if $INCREMENT(jj)
    . set result=result+(jj*player(winner,i))

    w !,"result:",result


/// restore player1 & player2 decks from file.
    new player
    merge player=decksInitial
/// if there was a previous round in this game that had exactly the same cards 
/// in the same order in the same players' decks, the game instantly ends in a win for player 1.
    new configurations, winner
    set winner=$$subgame($NAME(player))


    //do ##class(aoc.file).printArr($NAME(player))

    w !,"part 2"
    w !,"winner:",winner

    quit

subgame(ref)
    new ind1, ind2, card1, card2, winner
    for  set ind1=$ORDER(@ref@(1,"")), ind2=$ORDER(@ref@(2,"")) quit:ind1=""!(ind2="")  quit:$$configurationMatching(ref)=1  do
    . if $$configurationStore(ref)
    . set card1=$GET(@ref@(1,ind1))
    . set card2=$GET(@ref@(2,ind2))
    . //subgame 
    . if (@ref@(1)-1)>=card1 if (@ref@(2)-1)>=card2 do
    .. new playerSub, v, h
    .. set v="" set h=ind1 
    .. for  set h=$ORDER(@ref@(1,h)) quit:h=""  if $INCREMENT(v) quit:v>card1  set playerSub(1,v)=@ref@(1,h)
    .. set v="" set h=ind2
    .. for  set h=$ORDER(@ref@(2,h)) quit:h=""  if $INCREMENT(v) quit:v>card2  set playerSub(2,v)=@ref@(2,h)
    .. set playerSub(1)=@ref@(1)
    .. set playerSub(2)=@ref@(2)
    .. set winner=$$subgame($NAME(playerSub))
    . 
    . else  if card1>card2 set winner=1
    . else  if card2>card1 set winner=2
    .
    . if winner=1 do  quit
    .. set @ref@(1,$ORDER(@ref@(1,""),-1)+1)=card1 
    .. set @ref@(1,$ORDER(@ref@(1,""),-1)+1)=card2 
    .. kill @ref@(1,ind1), @ref@(2,ind2)
    .. if $INCREMENT(@ref@(1))
    .. if $INCREMENT(@ref@(2),-1)
    .
    . if winner=2 do  quit
    .. set @ref@(2,$ORDER(@ref@(2,""),-1)+1)=card2
    .. set @ref@(2,$ORDER(@ref@(2,""),-1)+1)=card1 
    .. kill @ref@(1,ind1), @ref@(2,ind2)
    .. if $INCREMENT(@ref@(2))
    .. if $INCREMENT(@ref@(1),-1)

    new winner
    set winner=$ORDER(@ref@(""))
    quit winner


configurationMatching(ref)   
    new configurationExist, t
    set configurationExist=0
    set t="" for  set t=$ORDER(configurations(t)) quit:t=""  quit:configurationExist=1  do
    . new match, currentCard, storedCard, index, playerC, tt
    . set match=1
    . for playerC=1,2 set tt="" for  set tt=$ORDER(@ref@(playerC,tt)) quit:tt=""  quit:match=0  do
    .. if $INCREMENT(index)
    .. set currentCard=@ref@(playerC,tt)
    .. set storedCard=$GET(configurations(t,playerC,index))
    .. if currentCard'=storedCard set match=0
    . if match=1 set configurationExist=1

    quit configurationExist

configurationStore(ref)
    new playerC, ind, cc
    if $INCREMENT(configurations)
    for playerC=1,2 set ind="" set cc="" for  set cc=$ORDER(@ref@(playerC,cc)) quit:cc=""  do
    . if $INCREMENT(ind)
    . set configurations(configurations,playerC,ind)=@ref@(playerC,cc)

    quit 1
    

    //do ##class(aoc.file).printArr($NAME(player))
}

}
