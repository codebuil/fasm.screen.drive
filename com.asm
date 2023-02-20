        ORG   100h
USE16
call intF0set
        mov ax,msg3
        mov edx,0
        int 0xf0
        mov ax,msg2
        mov edx,0
        int 0xf0
        mov edx,2
        int 0xf0
        mov ax,msg10
        mov edx,0
        int 0xf0
        mov ax,msg11
        mov edx,0
        int 0xf0
        mov ax,msg12
        mov edx,0
        int 0xf0
        mov ax,msg13
        mov edx,0
        int 0xf0
call exit
ret
scrollb8000:
        push eax
        push ebx
        push ecx
        push edx
        push edi
        push esi
        push ds
        push es
        mov edi,0xb8000
        mov esi,0xb8000
        mov eax,160
        add esi,eax
        mov eax,0
        mov es,ax
        mov ecx,2080
        scrollb8000s:
                es
                mov word ax,[esi]
                es
                mov word [edi],ax
                inc esi
                inc esi
                inc edi
                inc edi
                dec ecx
                cmp ecx,0
                jnz scrollb8000s

        pop es
        pop ds
        pop esi
        pop edi
        pop edx 
        pop ecx
        pop ebx
        pop eax
        ret
print:
        push eax
        push ebx
        push ecx
        push edx
        push edi
        push esi
        push ds
        push es
        push ax
        mov ecx,ebx
        cs
        mov dword eax,[xxxx]
        pop bx
        call copyb8000
        cs
        mov dword [xxx],0
        cs
        mov dword eax,[yyy]
        inc eax
        cs
        mov dword [yyy],eax
        cmp eax,24
        jb prints
        mov eax,23
        push eax
        push ebx
        call scrollb8000
        pop ebx
        pop eax
        prints:
        mov ebx,eax
        mov eax,0
        call locate
        pop es
        pop ds
        pop esi
        pop edi
        pop edx 
        pop ecx
        pop ebx
        pop eax
        ret
locate:
        push eax
        push ebx
        push ecx
        push edx
        push edi
        push esi
        push ds
        push es
        cs
        mov dword [xxx],eax
        cs
        mov dword [yyy],ebx
        cmp eax,80
        jb locates
        cs
        mov dword [xxx],79
        locates:
        cmp ebx,24
        jb locatess
        cs
        mov dword [yyy],23
        locatess:
        push eax
        mov eax,ebx
        mov ebx,160
        mov edx,0
        mov ecx,0
        imul ebx
        pop ebx
        add eax,ebx
        add eax,ebx
        cs
        mov [xxxx],eax
        pop es
        pop ds
        pop esi
        pop edi
        pop edx 
        pop ecx
        pop ebx
        pop eax
        ret
copyb8000:
        push eax
        push ebx
        push ecx
        push edx
        push edi
        push esi
        push ds
        push es
        mov edi,0b8000h
        add edi,eax
        mov eax,0
        mov ds,ax
        cs
        mov ah,[colorss]
        push cs
        pop es
        copyb8000ss:
                es
                mov al,[bx]
                cmp al,27
                jnz copyb8000ssss
                call escapeCode
                copyb8000ssss:
                ds
                mov [edi],ax
                inc ebx
                inc edi
                inc edi
                cmp al,0
                jnz copyb8000ss
        copyb8000sss:
         pop es
        pop ds
        pop esi
        pop edi
        pop edx 
        pop ecx
        pop ebx
        pop eax
        ret
clear:
        push eax
        push ebx
        push ecx
        push edx
        push edi
        push esi
        push ds
        push es
        mov edx,eax
        mov ax,0
        mov ds,ax
        mov es,ax
        mov edi,0b8000h
        mov ecx,2160
        cs
        mov ah,[colorss]
        mov al,20h
        clearss:
                ds
                mov[edi],ax
                inc edi
                inc edi
                dec ecx
                cmp ecx,0h
                jnz clearss
        pop es
        pop ds
        pop esi
        pop edi
        pop edx 
        pop ecx
        pop ebx
        pop eax
        ret
escapeCode:
        push ecx
        push edx
        push esi
        push ds
        push es
        push edi
        mov ch,0
        mov cl,0
        mov dl,0
        mov dh,0
        mov si,0
        mov di,0
        escapeCodes:
               inc bx
               es
               mov al,[bx]
               cmp al,27
               jz escapeCodes
               cmp al,0
               jnz escapeCodess8
               pop edi
               jmp escapeCodess
               escapeCodess8:
               cmp al,'c'
               jnz escapeCodesss
               call clear
               inc bx
               pop edi
               jmp escapeCodess
               escapeCodesss:
               cmp al,'['
               jnz escapeCodess
               escapeCodessss:
               inc bx
               es
               mov al,[bx]
               cmp al,0
               jnz escapeCodess16
               jmp escapeCodess
               escapeCodess16:
               cmp al,27
               jz escapeCodes
               cmp al,'f'
               jz escapeCodessf
               cmp al,'m'
               jz escapeCodessm
               cmp al,';'
               jnz escapeCodessv
               inc dh
               mov dl,0
               jmp escapeCodessss
               escapeCodessv:
               cmp al,'0'
               jb escapeCodess
               cmp al,'9'
               ja escapeCodess
               sub al,'0'
               cmp dl,0
               jnz escapeCodessdl1
               mov ah,0
               push dx
               push cx
               push bx
               mov bx,10
               imul bx
               pop bx
               pop cx
               pop dx
               mov ah,0
               or si,ax
               inc dl
               jmp escapeCodessdl2
               escapeCodessdl1:
               push bx
               mov ah,0
               or si,ax
               pop bx
               escapeCodessdl2:
               cmp dh,0
               jnz escapeCodessdh1
               mov di,si
               mov si,0
               escapeCodessdh1:
               jmp escapeCodessss
               escapeCodessf:
               pop eax
               inc bx
               push bx
               mov eax,0
               mov ebx,0
               mov bx,di
               mov ax,si
               call locate
                       cs
                       mov dword eax,[xxxx]
                       mov edi,eax
                       mov eax,0b8000h
                       add edi,eax
               pop bx

               jmp escapeCodess
               escapeCodessm:
               push bx
               mov eax,0
               sub si,30
               sub di,30
               cmp si,9
               jb escapeCodessmm
               sub si,10
               and si,3
               shl si,4
               or ax,si
               jmp escapeCodessmm2
               escapeCodessmm:
               and si,3
               or ax,si
               escapeCodessmm2:
               cmp di,9
               jb escapeCodessmmm
               sub di,10
               and di,3
               shl di,4
               or ax,di
               jmp escapeCodessmmm2
               escapeCodessmmm:
               and di,3
               or ax,di
               escapeCodessmmm2:
               call setColor
               pop bx
               pop edi
               jmp escapeCodess
        escapeCodess:
        cs
        mov ah,[colorss]
        es
        mov al,[bx]
        pop es
        pop ds
        pop esi
        pop edx 
        pop ecx
        ret
setColor:
        push eax
        push ebx
        push ecx
        push edx
        push edi
        push esi
        push ds
        push es
        cs
        mov [colorss],al
        pop es
        pop ds
        pop esi
        pop edi
        pop edx 
        pop ecx
        pop ebx
        pop eax
        ret
exit:
mov ax,0
int 21h
ret
intF0set:
        push ds
        mov ax,0
        mov ds,ax
        mov cx,cs
        mov dx,IntF0
        mov bx,960
        ds
        mov [bx],dx
        inc bx
        inc bx
        ds
        mov [bx],cx
        pop ds
ret
IntF0:
        push eax
        push ebx
        push ecx
        push edx
        push edi
        push esi
        push ds
        push es
             cmp edx,0
             jnz IntF00
             call print
             IntF00:
             cmp edx,1
             jnz IntF01
             call clear
             IntF01:
             cmp edx,2
             jnz IntF02
             call locate
             IntF02:
             cmp edx,3
             jnz IntF03
             call setColor
             IntF03:

        pop es
        pop ds
        pop esi
        pop edi
        pop edx 
        pop ecx
        pop ebx
        pop eax
        iret
xxx:
dd 0
yyy:
dd 0
xxxx:
dd 0
yyyy:
dd 0
colorss:
dd 2
msg10:
db 27,"[00;00fhello world...",0
msg11:
db 27,"[01;01fhello world...",0
msg12:
db 27,"[02;02fhello world...",0
msg13:
db 27,"[06;28fhello world...",0
msg2:
db 27,"c",0
msg3:
db 27,"[42;30m",0