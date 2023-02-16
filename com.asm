        ORG   100h
USE16
call intF0set
        mov edx,1
        mov eax,0x20
        int 0xf0
mov eax,0
mov ebx,22
        mov edx,2
        int 0xf0
mov ecx,16
for1:
        mov ax,msg
        mov ebx,0x20
        mov edx,0
        int 0xf0
        dec ecx
        cmp ecx,0
        jnz for1
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
        mov ecx,4000
        scrollb8000s:
                es
                mov byte al,[esi]
                es
                mov byte [edi],al
                inc esi
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
        ds
        mov dword eax,[xxxx]
        pop bx
        call copyb8000
        ds
        mov dword [xxx],0
        ds
        mov dword eax,[yyy]
        inc eax
        ds
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
        mov dword [xxx],eax
        ds
        mov dword [yyy],ebx
        cmp eax,80
        jb locates
        ds
        mov dword [xxx],79
        locates:
        cmp ebx,24
        jb locatess
        ds
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
        ds
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
        mov ah,cl
        push cs
        pop es
        copyb8000ss:
                es
                mov al,[bx]
                ds
                mov [edi],al
                inc ebx
                inc edi
                ds
                mov [edi],ah
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
        mov ecx,2080
        mov ah,dl
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
msg:
db "hello world...",0
