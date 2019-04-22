Option Explicit 'force all variables to be declared

'Wscript.Arguments.Item(0) = loja
'Wscript.Arguments.Item(1) = IP
'Wscript.Arguments.Item(2) = caixa 
'Wscript.Arguments.Item(3) = diretorio origem listar
'Wscript.Arguments.Item(4) = diretorio salvar resultado

Const ForWriting = 2
Dim objFSO
Set objFSO = CreateObject("Scripting.FileSystemObject")

Dim objTS 'Text Stream Object
Set objTS = objFSO.OpenTextFile(Wscript.Arguments.Item(4), 8, True)

Recurse objFSO.GetFolder(Wscript.Arguments.Item(3))
objTS.Close()

Sub Recurse(objFolder)
    Dim objFile, objSubFolder

    For Each objFile In objFolder.Files
        If LCase(objFSO.GetExtensionName(objFile.Name)) = "xml" Then
		    objTS.WriteLine(Wscript.Arguments.Item(0) &","& Wscript.Arguments.Item(1) &","& Wscript.Arguments.Item(2) &","& objfile.Name &","& objFile.DateLastModified)
        End If
    Next

    For Each objSubFolder In objFolder.SubFolders
        Recurse objSubFolder
    Next
End Sub


'File properties:
'  strFilePath = chr(34) & objFile.Path & chr(34)
'  strFileName = chr(34) & objFile.Name & chr(34)
'  strFileSize = objFile.Size / 1024
'  strFileType = chr(34) & objFile.Type & chr(34)
'  strFileDateCreated = objFile.DateCreated
'  strFileDateLastAccessed = objFile.DateLastAccessed
'  strFileDateLastModified = objFile.DateLastModified
'OpenTextFile parameters:
'  IOMode
'  1=Read
'  2=write
'  8=Append
'Create (true,false)

 