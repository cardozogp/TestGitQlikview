Dim fso, Qv
' create a global copy of the filesystem object

Set fso = CreateObject("Scripting.FileSystemObject")
Set Qv = CreateObject("QlikTech.QlikView")

RecurseFolders ".","1.Extract"
RecurseFolders ".","2.Transform"
RecurseFolders ".","3.Load"
 
 Set fso = Nothing
Qv.Quit
Set Qv = Nothing
 
Sub RecurseFolders(sPath,Target)
 
With fso.GetFolder(sPath)
    if .SubFolders.Count > 0 Then
        For Each Folder In .SubFolders
            if Left(Folder.Name, 1) <> "." Then
                if Folder.name=Target Then
					for each File in Folder.Files
						If fso.getExtensionName(File.Name)= "qvw" Then
							OpenClose(File)
						end if
					Next
				end if
            RecurseFolders folder.Path, Target
            End If
        Next
    End if
End With
 
End Sub	

Function OpenClose(qvwFullPath)
  Set docObj = Qv.OpenDocEx (qvwFullPath,0,false)  ' Open the document
  docObj.Reload
  docObj.Save
  docObj.CloseDoc
End Function