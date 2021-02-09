Class aoc.file [ Not ProcedureBlock ]
{

ClassMethod load(file, arrRef)
{
	new dir, path
    ;set dir=##class(%SYSTEM.Process).CurrentDirectory() 
    set dir="C:\repos\objectscript-docker-template\input data\"
    set path=dir_file
	
    if '##class(%File).Exists(path) quit
 
	set stream=##class(%Stream.FileCharacter).%New()
    set sc=stream.LinkToFile(path)
	if 'sc do $system.Status.DisplayError(sc) quit
    new array
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set array($increment(array))=line
		}
	m @arrRef=array
	quit
}

ClassMethod printArr(ref)
{
	for  set ref=$QUERY(@ref) quit:ref=""  w !,ref,"=",$GET(@ref)
}

ClassMethod printArrRow(ref)
{
	n g
	set g="" f  s g=$O(@ref@(g)) q:g=""  w " ",$GET(@ref@(g))
	//for  set ref=$QUERY(@ref) quit:ref=""  w " ",$GET(@ref)
}

}
