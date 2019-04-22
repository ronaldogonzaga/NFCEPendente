 

SCHTASKS /DELETE /F /TN "nfcePendente"
SCHTASKS /END /TN "nfcePendente"
SCHTASKS /create /F /tn "nfcePendente" /tr "D:\Scripts\nfcePendente\aux_IsOnline.bat" /sc ONCE /st 23:50 /RU %HOSTNAME%\Administrador /RP xxxxxx
SCHTASKS /ENABLE /TN "nfcePendente"
SCHTASKS /RUN /TN "nfcePendente"
SCHTASKS /DISABLE /TN "nfcePendente"
