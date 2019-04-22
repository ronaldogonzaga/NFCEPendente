@echo off
rem ###################################
set ipsalvar=\\172.22.22.xxx\nfcePendente
rem ###################################


echo LOJA,IP,CAIXA,ARQUIVO,DATA>%ipsalvar%\Pendente.csv
echo LOJA,IP,CAIXA,ARQUIVO,DATA>%ipsalvar%\Rejeicao.csv
if not exist %ipsalvar%\Log md %ipsalvar%\Log
net use u: /delete /yes
if not exist %ipsalvar%\Log net use u: %ipsalvar% /user:administrador xxxx
explorer.exe %ipsalvar%
for /f "tokens=*" %%o in (listafull.txt) do (echo Executando>%ipsalvar%\Log\%%o)

for /f "tokens=*" %%o in (listafull.txt) do (
    TITLE %%o
	net use \\%%o\D$ /user:administrador xxxx
	if exist \\%%o\D$ xcopy aux*.* \\%%o\D$\Scripts\nfcePendente\ /y/i/c
    if exist \\%%o\D$ psexec -d -u administrador -p xxxx \\%%o D:\Scripts\nfcePendente\aux_Inst.bat
)
