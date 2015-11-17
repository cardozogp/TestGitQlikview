@echo off
@echo ## Run VariableEditor as Administrator
:: Change VEPath if Deployment Framework structure is modified 
SET VEPath=\6.Script\2.VariableEditor 
:: Mount folder in VEPath 
pushd "%~dp0%VEPath%" 
:: Execute VariableEditor.qvw 
VariableEditor.qvw 
:: Unmount folder 
popd 