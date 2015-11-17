Dim fso, Qv
' create a global copy of the filesystem object
Set fso = CreateObject("Scripting.FileSystemObject")
Set Qv = CreateObject("QlikTech.QlikView")
 
' Call the RecurseFolders routine
' Takes one argument - in this case, the Path of the folder to be searched
RecurseFolders "."
 
' echo the job is completed
WScript.Echo "Completed!"
 
' clean up
Set fso = Nothing
Qv.Quit
Set Qv = Nothing
 
Sub RecurseFolders(sPath)
 
With fso.GetFolder(sPath)
    if .SubFolders.Count > 0 Then
        For Each Folder In .SubFolders
             WScript.Echo folder.path
            Set Files = Folder.Files
                For Each File in Files
                If fso.GetExtensionName(File.Name) = "qvw" Then
                    WScript.Echo File.Name
					If Not fso.FolderExists(Replace(File ,".qvw","-prj")) Then
					  fso.CreateFolder(Replace(File ,".qvw","-prj"))
					End If
                    
                    OpenClose(File)
				else	 
				WScript.Echo "No file found!"
                End If
            Next 
            ' Recurse to check for further subfolders
        RecurseFolders folder.Path
        Next
        End if
End With
 
End Sub
 
Function OpenClose(qvwFullPath)
  Set docObj = Qv.OpenDocEx (qvwFullPath,0,false)  ' Open the document
  docObj.Save
  docObj.CloseDoc
  OpenClose = qvwFullPath
End Function