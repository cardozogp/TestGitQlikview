Dim fso
' create a global copy of the filesystem object
Set fso = CreateObject("Scripting.FileSystemObject")
 
TemplatePath = fso.GetAbsolutePathName(".") & "\qvw.template"
'<a id="ctl00_FullRegion_PC_148_1_EditForm_MainBody_ctl00_resize" class="mceResize" onclick="return false;" href="javascript:;"></a>' WScript.Echo TemplatePath
 
' Call the RecurseFolders routine
' Takes one argument - in this case, the Path of the folder to be searched
RecurseFolders "."
 
' echo the job is completed
' WScript.Echo "Completed!"
 
Sub RecurseFolders(sPath)
 
With fso.GetFolder(sPath)
    if .SubFolders.Count > 0 Then
        For Each Folder In .SubFolders
            if Left(Folder.Name, 1) <> "." Then
                If InStr(1, folder.Path, "-prj") <> 0 Then
                    ' Copy and rename template to create empty qvd file next to prj folder
                    If fso.FileExists(TemplatePath) Then
                        fso.CopyFile TemplatePath, Replace(folder.Path ,"-prj",".qvw"), True
                    End If
                End If 
            ' Recurse to check for further subfolders
            RecurseFolders folder.Path
            End If
        Next
    End if
End With
 
End Sub