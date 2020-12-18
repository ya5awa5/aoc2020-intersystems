Class aoc.day1 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName set fileName="day1.txt"
	new arrRef set arrRef=$name(^mtempX420) kill @arrRef
	do ##class(aoc.file).load(fileName, arrRef)
	
	new i, j, k, entry1, entry2, entry3, successFLag
	set successFLag=0
/// part 1
	set i="" for  set i=$ORDER(@arrRef@(i)) QUIT:i=""  QUIT:successFLag=1  do 
	. set entry1=$get(@arrRef@(i)) QUIT:entry1=""
	. set j=i for  set j=$ORDER(@arrRef@(j)) QUIT:j=""  QUIT:successFLag=1  do
	.. set entry2=$get(@arrRef@(j)) QUIT:entry2=""
        .. if entry1 + entry2 = 2020 do  
	... w entry1_" + "_entry2_" = "_(entry1 + entry2)
	... w $C(10,13)
	... w entry1_" * "_entry2_" = "_(entry1 * entry2)
        ... set successFLag=1

/// part 2   
	set successFLag=0
	set i="" for  set i=$ORDER(@arrRef@(i)) QUIT:i=""  QUIT:successFLag  do 
	. set entry1=$get(@arrRef@(i)) QUIT:entry1=""
	. set j=i for  set j=$ORDER(@arrRef@(j)) QUIT:j=""  QUIT:successFLag  do
	.. set entry2=$get(@arrRef@(j)) QUIT:entry2=""
	.. set k=j for  set k=$ORDER(@arrRef@(k)) QUIT:k=""  QUIT:successFLag  do
	... set entry3=$get(@arrRef@(k)) QUIT:entry3=""
        ... if ((entry1 + entry2 + entry3) = 2020) do  
	.... w $C(10,13)
	.... w entry1_" + "_entry2_" + "_entry3_" = "_(entry1 + entry2 + entry3)
	.... w $C(10,13)
	.... w entry1_" * "_entry2_" * "_entry3_" = "_(entry1 * entry2 * entry3)
	.... set successFLag=1
}

}
