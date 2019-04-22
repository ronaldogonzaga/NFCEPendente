@echo off
rem esse script roda direto em cada servidor de loja
rem %1 = IP
rem %2 = FILIAL
rem %3 = ip onde salvar
if not exist %3\Log net use %3 /user:172.22.22.xxxxx\administrador xxxxxx
title %1
pushd D:\Scripts\nfcePendente

for /f "delims=" %%a in ('call aux_ReadINI.bat /s Opcoes /i NumeroCaixa \\%1\C$\TERMINAL\mpvenda.ini') do (
  set val=%%a
)

set _TMP=
if exist \\%1\C$\TERMINAL\nfce\Caixa%val%\Pendente set _TMP=\\%1\C$\TERMINAL\nfce\Caixa%val%\Pendente
if exist \\%1\C$\TERMINAL\nfce\Caixa0%val%\Pendente set _TMP=\\%1\C$\TERMINAL\nfce\Caixa0%val%\Pendente
if exist \\%1\C$\TERMINAL\nfce\Caixa00%val%\Pendente set _TMP=\\%1\C$\TERMINAL\nfce\Caixa00%val%\Pendente


IF {%_TMP%}=={} (
  goto goodbye
) ELSE (
     cscript aux_FileProperties.vbs %2 %1 %val% %_TMP% %3\Pendente.csv
    
)

:goodbye

title Fechar
TASKKILL /F /FI "WINDOWTITLE eq Fechar"
