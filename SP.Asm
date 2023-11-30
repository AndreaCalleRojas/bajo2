format PE GUI 4.0
entry inicio

include 'Win32a.inc'


ventana_1	equ		1
salir_btn	equ		1000

section '.data' data readable writeable

Ist  dd 0
pWnd dd 0
entrada dd 0
mifecha SYSTEMTIME ?
mifecha2 SYSTEMTIME ?
mifecha3 SYSTEMTIME ?
midia SYSTEMTIME ?


caja db "Caja de mensaje",0
mensaje1 db "NO HAY CLASE EN CURSO",0
mensaje2 db "RETRASO",0
mensaje3 db "ERROR",0
mensaje4 db "HOY NO TIENE CLASES",0
mensaje5 db "NO HAY CLASES",0

docente1 db "DOCENTE: CESPEDES GUIZADA MARIA BENITA",0
materia1 db "MATERIA: INGLES I",0
aula1 db "AULA: 693B",0
hora1 db "HORARIO: 8:15 - 9:45",0

docente2 db "DOCENTE: VALENZUELA MIRANDA ROBERTO",0
materia2 db "MATERIA: FISICA GENERAL",0
aula21 db "AULA: 651",0
aula22 db "AULA: 692C",0
hora21 db "HORARIO: 11:15 - 12:45",0
hora22 db "HORARIO: 14:15 - 15:45",0

docente3 db "DOCENTE: USTARIZ VARGAS HERNAN",0
materia3 db "MATERIA: INTRODUCCION A LA PROGRAMACION",0
aula3 db "AULA: 607",0
hora3 db "HORARIO: 12:45 - 14:15",0

docente4 db "DOCENTE: AGREDA CORRALES LUIS ROBERTO",0
materia4 db "MATERIA: ARQUITECTURA DE COMPUTADORAS II",0
aula4 db "AULA: 651",0
hora4 db "HORARIO: 15:45 - 17:15",0

docente5 db "DOCENTE: ACHA PEREZ SAMUEL",0
materia5 db "MATERIA: ARQUITECTURA DE COMPUTADORAS I",0
aula5 db "AULA: 693B",0
hora5 db "HORARIO: 6:45 - 8:15",0

numero dd 0
numero2 dd 0
vardia dd 0
varhora dd 0
varmin dd 0
;Agregar aqui el registro de memoria correspondiente
section '.code' code readable executable

inicio:
	invoke GetModuleHandle,0
	mov [Ist],eax
	invoke DialogBoxParam,eax,ventana_1,0,DlgProc,0 
fin:
	invoke ExitProcess,0

proc DlgProc,hWnd,uMsg,wParam,lParam
	push edi esi ebx
	
	mov eax,[uMsg]
	cmp	eax,WM_COMMAND
	je	jCOMMAND
	cmp	eax,WM_INITDIALOG
	je	jINITDIALOG
	cmp	eax,WM_CLOSE
	je	jCLOSE
	xor eax,eax
	jmp finish

jINITDIALOG:
	mov eax,[hWnd]
	mov [pWnd],eax
	
	mov eax,1
	jmp finish
	
jCOMMAND:
	mov eax,[wParam]
	cmp	eax,salir_btn
	je	salir
	cmp	eax,1004
	je	registrar
	xor eax,eax
	jmp finish
	
salir:
	invoke SendMessage,[hWnd],WM_CLOSE,0,0
	mov eax,1
	jmp finish
	
registrar:
	invoke GetDlgItemInt,[hWnd],1001,entrada,1
	cmp [entrada],0
	je error
	mov dword [numero],eax
	cmp eax,98765
	je fechaD1
	cmp eax,87654
	je fechaD2
	cmp eax,76543
	je fechaD3
	cmp eax,65432
	je fechaD4
	cmp eax,54321
	je fechaD5
	jne noregistrado
	mov eax,1
	jmp finish
	
fechaD1:	;primerdocente
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 2
	je fechaH1
	cmp [vardia], 5
	je fechaH1
	jne falta2
	mov eax,1
	jmp finish
	
fechaD2:
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 2
	je fechaH2
	cmp [vardia], 3
	je fechaH21
	jne falta2
	mov eax,1
	jmp finish
fechaD3:
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 1
	je fechaH3
	cmp [vardia], 3
	je fechaH3
	jne falta2
	mov eax,1
	jmp finish

fechaD4:
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 2
	je fechaH4
	cmp [vardia], 4
	je fechaH4
	jne falta2
	mov eax,1
	jmp finish

fechaD5:
	xor eax,eax
	invoke GetLocalTime,midia
	mov ax,[midia.wDayOfWeek]
	mov [vardia],eax
	cmp [vardia], 4
	je fechaH5
	cmp [vardia], 6
	je fechaH5
	jne falta2
	mov eax,1
	jmp finish
	
fechaH1:	;primer docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],9
	je fechaM11
	cmp [varhora],8
	je fechaM1
	jne sinclase
	mov eax,1
	jmp finish
fechaM1:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],15
	jg horamax
	jne sinclase
	mov eax,1
	jmp finish

fechaM11:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],44
	jng falta
	jne sinclase
	mov eax,1
	jmp finish

horamax:
	cmp [varmin],29
	jng mostrar1
	jne falta
	mov eax,1
	jmp finish

fechaH2:	;segundo docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],12
	je fechaM2f
	cmp [varhora],11
	je fechaM2
	jne sinclase
	mov eax,1
	jmp finish
fechaM2:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],15
	jg horamax2
	jne sinclase
	mov eax,1
	jmp finish

fechaH21:	;segundo docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],15
	je fechaM2f
	cmp [varhora],14
	je fechaM21
	jne sinclase
	mov eax,1
	jmp finish

fechaM21:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],15
	jg horamax21
	jne sinclase
	mov eax,1
	jmp finish

fechaM2f:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],44
	jng falta
	jne sinclase
	mov eax,1
	jmp finish	

horamax2:
	cmp [varmin],29
	jng mostrar2
	jne falta
	mov eax,1
	jmp finish
	
horamax21:
	cmp [varmin],29
	jng mostrar21
	jne falta
	mov eax,1
	jmp finish
	
fechaH3:	;tercer docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],14
	je fechaM31
	cmp [varhora],13
	je falta
	cmp [varhora],12
	je fechaM3
	jne sinclase
	mov eax,1
	jmp finish
fechaM3:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],45
	jg horamax3
	jne sinclase
	mov eax,1
	jmp finish
	
fechaM31:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],14
	jng falta
	jne sinclase
	mov eax,1
	jmp finish
	
horamax3:
	cmp [varmin],59
	jng mostrar3
	jne falta
	mov eax,1
	jmp finish
	
fechaH4:	;cuarto docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],17
	je fechaM41
	cmp [varhora],16
	je falta
	cmp [varhora],15
	je fechaM4
	jne sinclase
	mov eax,1
	jmp finish
fechaM4:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],45
	jg horamax4
	jne sinclase
	mov eax,1
	jmp finish

fechaM41:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],14
	jng falta
	jne sinclase
	mov eax,1
	jmp finish
horamax4:
	cmp [varmin],59
	jng mostrar4
	jne falta
	mov eax,1
	jmp finish
	
fechaH5:	;quinto docente
	xor eax,eax
	invoke GetLocalTime,mifecha
	mov ax,[mifecha.wHour]
	mov [varhora],eax
	cmp [varhora],8
	je fechaM51
	cmp [varhora],7
	je falta
	cmp [varhora],6
	je fechaM5
	jne sinclase
	mov eax,1
	jmp finish
fechaM5:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],45
	jg horamax5
	jne sinclase
	mov eax,1
	jmp finish

fechaM51:
	xor eax,eax
	invoke GetLocalTime,mifecha2
	mov ax,[mifecha2.wMinute]
	mov [varmin],eax
	cmp [varmin],14
	jng falta
	jne sinclase
	mov eax,1
	jmp finish
	
horamax5:
	cmp [varmin],59
	jng mostrar5
	jne falta
	mov eax,1
	jmp finish

mostrar1:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente1
	invoke SendDlgItemMessage,[hWnd],1005,WM_SETTEXT,10,materia1
	invoke SendDlgItemMessage,[hWnd],1006,WM_SETTEXT,10,aula1
	invoke SendDlgItemMessage,[hWnd],1007,WM_SETTEXT,10,hora1
	jmp finish
mostrar2:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente2
	invoke SendDlgItemMessage,[hWnd],1005,WM_SETTEXT,10,materia2
	invoke SendDlgItemMessage,[hWnd],1006,WM_SETTEXT,10,aula21
	invoke SendDlgItemMessage,[hWnd],1007,WM_SETTEXT,10,hora21
	jmp finish
	
mostrar21:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente2
	invoke SendDlgItemMessage,[hWnd],1005,WM_SETTEXT,10,materia2
	invoke SendDlgItemMessage,[hWnd],1006,WM_SETTEXT,10,aula22
	invoke SendDlgItemMessage,[hWnd],1007,WM_SETTEXT,10,hora22
	jmp finish
mostrar3:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente3
	invoke SendDlgItemMessage,[hWnd],1005,WM_SETTEXT,10,materia3
	invoke SendDlgItemMessage,[hWnd],1006,WM_SETTEXT,10,aula3
	invoke SendDlgItemMessage,[hWnd],1007,WM_SETTEXT,10,hora3
	jmp finish
mostrar4:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente4
	invoke SendDlgItemMessage,[hWnd],1005,WM_SETTEXT,10,materia4
	invoke SendDlgItemMessage,[hWnd],1006,WM_SETTEXT,10,aula4
	invoke SendDlgItemMessage,[hWnd],1007,WM_SETTEXT,10,hora4
	jmp finish
mostrar5:
	invoke SendDlgItemMessage,[hWnd],1003,WM_SETTEXT,10,docente5
	invoke SendDlgItemMessage,[hWnd],1005,WM_SETTEXT,10,materia5
	invoke SendDlgItemMessage,[hWnd],1006,WM_SETTEXT,10,aula5
	invoke SendDlgItemMessage,[hWnd],1007,WM_SETTEXT,10,hora5
	jmp finish
	
sinclase:
	invoke MessageBox,[hWnd],mensaje5,caja,MB_OK
	jmp finish
falta:
	invoke MessageBox,[hWnd],mensaje2,caja,MB_OK
	jmp finish
	
falta2:
	invoke MessageBox,[hWnd],mensaje4,caja,MB_OK
	jmp finish
	
error:
	invoke MessageBox,[hWnd],mensaje3,caja,MB_OK
	jmp finish
	
noregistrado:
	invoke MessageBox,[hWnd],mensaje1,caja,MB_OK
	jmp finish
	
jCLOSE:	
	invoke EndDialog,[hWnd],0
	mov eax,1
	
finish:
	pop ebx esi edi
	ret
endp

section '.idata' import data readable writeable
  ;importamos solo los procedimientos basicos para abrir una ventana

  ;otra forma para importar los procedimientos importando archivos INC
  library kernel32,'KERNEL32.DLL',user32,'USER32.DLL',gdi32,'GDI32.DLL'
  include 'api\kernel32.inc'
  include 'api\user32.inc'
  include 'api\gdi32.inc'
  

section '.rsrc' resource from 'SP.res' data readable
