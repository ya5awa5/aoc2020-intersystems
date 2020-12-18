Class util.file [ Not ProcedureBlock ]
{
    ClassMethod load(file, arrRef)
{
	new dir set dir=##class(%SYSTEM.Process).CurrentDirectory()
	new path set path=dir_file
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
}