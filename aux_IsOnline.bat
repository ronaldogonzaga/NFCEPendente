@echo off
rem ###################################
set ipsalvar=\\172.22.22.xxxxx\nfcePendente
rem ###################################


TITLE NFCE Pendente - Rejeitados
pushd D:\Scripts\nfcePendente
if not exist %3\Log net use %3 /user:administrador xxxxx

set oct1=
set oct2=
set oct3=

for /f "tokens=2 delims=[]" %%a in ('ping %computername% -4 -n 1') do (
  for /f "tokens=1 delims=." %%b in ("%%a") do (set oct1=%%b )
  for /f "tokens=2 delims=." %%b in ("%%a") do (set oct2=%%b )
  for /f "tokens=3 delims=." %%b in ("%%a") do (set oct3=%%b )
)
set str=%oct1%.%oct2%.%oct3%
set str=%str: =%
set loja=%oct2%
set loja=%loja: =%

FOR /L %%i in (10,1,250) do (
   if %%i==150 del %ipsalvar%\Log\%str%.100
   if %%i==150 del %ipsalvar%\Log\%str%.8
   ping -n 2 %str%.%%i | find "TTL=" >nul
   if errorlevel 1 (
       echo %str%.%%i Offline
   ) else (
   	  echo %str%.%%i Online
	  net use \\%str%.%%i\C$ /user:%str%.%%i\pdv pdv
	  if exist \\%str%.%%i\C$\TERMINAL\mpvenda.ini start aux_Pendente.bat %str%.%%i %loja% %ipsalvar%
	  if exist \\%str%.%%i\C$\TERMINAL\mpvenda.ini start aux_Rejeicao.bat %str%.%%i %loja% %ipsalvar%
         )
   )
   :goodbye
   set _TMP=null
)
