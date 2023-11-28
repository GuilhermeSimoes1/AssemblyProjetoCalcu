; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.model small
.data
    option db 0

    menu_prompt db 'Escolha uma opcao:', '$'
    menu db 0Ah,0Dh, '1 - DivisÇo Inteira', 0Ah, 0Dh, '2 - Adi',87h,'Ço', 0Ah, 0Dh, '3 - Subtra',87h,'Ço', 0Ah, 0Dh, '4 - Raiz Quadrada', 0Ah, 0Dh,  '5 - CartÇo de CidadÇo', 0Ah, 0Dh, '6 - Numero de Identifica',87h,'Ço Fiscal', 0Ah, 0Dh, 'S - Sair', 0Ah, 0Dh,'$'
    
    ;Adicao
    newlinee db 0Ah, 0Dh, '$'
    tit db 'Adi',87h,0C6h,'o', '$' 
    tit2 db 'Subtra',87h,0C6h,'o', '$'
    
    Op1 db 0Ah,0Dh, 'Introduza um valor:', '$'
    Op2 db 0Ah,0Dh, 'Introduza outro valor:', '$'
    Op3 db 0Ah,0Dh, 'Resultado = ', '$' 
    num1 db 0    
    num2 db 0
    res db 0
    
    
    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    display_menu:
        mov ah, 9
        lea dx, menu_prompt
        int 21h
        
        lea dx, menu
        int 21h
    
      
    
        
    get_option:
        mov ah, 1
        int 21h
        cmp al, 's'
        je exit_program
        cmp al, 'S'
        je exit_program
    
        sub al, 30h  
    
        cmp al, 1
        je option_1
        
        
        cmp al, 2
        je option_2
        cmp al, 3
        je option_3
    
        jmp invalid_option
        
        

    option_1:

    mov option, 1
    

    mov ah, 9

    int 21h
    mov ah, 9
    lea dx, menu_prompt
    int 21h
    mov ah, 9
    lea dx, option 
    int 21h

    jmp display_menu

    option_2: 
    
    mov option, 2
    jmp adicao

    option_3:
        
        mov option, 3
        jmp subtracao

    invalid_option:

        mov ah, 9
        int 21h
        mov ah, 9
        lea dx, menu_prompt
        int 21h
        mov ah, 9
        lea dx, menu
        int 21h
        jmp get_option

    exit_program:
        mov ah, 4Ch
        int 21h
        
    limpa_ecra proc
    mov  ah, 0
    mov  al, 3
    int  10H
    ret
    limpa_ecra endp
        
        
adicao:
 
        call limpa_ecra
        lea si, num1
        lea bx, num2
        lea di, res
        mov ax, @data
        mov ds, ax
;---------------------------------------------------- 
        
        mov ah, 9                                     ;Titulo
        lea dx, tit
        int 21h
;----------------------------------------------------        
        lea dx, Op1
        int 21h

        entrada:
        mov ah, 1   ; Ler o primeiro caractere        ;numero 1
        int 21h 
        
        sub al, '0'  ; Converta de ASCII para decimal
        mov num1, al
;----------------------------------------------------         
        mov ah, 9
        lea dx, Op2
        int 21h

        ; Ler o segundo caractere
                                                      ;numero 2
        mov ah, 1
        int 21h 
    
        sub al, '0'  ; Converta de ASCII para número
        mov num2, al 
;----------------------------------------------------        
        mov cx,5
        sum:
        
        mov al, [si]
        add al, [bx]
        mov [di], al
                                                      ;Soma
        inc si
        inc bx
        inc di
   
        loop sum
        
;----------------------------------------------------         
        
        ;apresenta o resultado
        
        mov ah, 9
        lea dx,Op3
        int 21h
                                                     ;resultado
        mov Ah, 2
        mov dl, res
        add dl,30h
        int 21h
                                     
       

;----------------------------------------------------        


        mov ah, 4Ch
        int 21h
   

ret

subtracao:
 
        call limpa_ecra
        lea si, num1
        lea bx, num2
        lea di, res
        mov ax, @data
        mov ds, ax
;---------------------------------------------------- 
        
        mov ah, 9                                     ;Titulo
        lea dx, tit2
        int 21h
;----------------------------------------------------        
        lea dx, Op1
        int 21h


        mov ah, 1   ; Ler o primeiro caractere        ;numero 1
        int 21h 
        
        add dl,30h  ; Converta de ASCII para decimal
        mov num1, al
;----------------------------------------------------         
        mov ah, 9
        lea dx, Op2
        int 21h

        ; Ler o segundo caractere
                                                      ;numero 2
        mov ah, 1
        int 21h 
    
        add dl,30h  ; Converta de ASCII para número
        mov num2, al 
;----------------------------------------------------        
        mov cx,5
        subtr:
        
        mov al, [si]
        sub al, [bx]
        mov [di], al
                                                      ;Soma
        inc si
        inc bx
        inc di
   
        loop subtr
        
;----------------------------------------------------         
        
        ;apresenta o resultado
        
        mov ah, 9
        lea dx,Op3
        int 21h
                                                     ;resultado
        mov Ah, 2
        mov dl, res
        add dl,30h
        int 21h
                                     
       

;----------------------------------------------------        


        mov ah, 4Ch
        int 21h
   

ret  