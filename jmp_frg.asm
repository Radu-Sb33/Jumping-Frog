.586
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "Jumper Frog Project",0
area_width EQU 900
area_height EQU 900
area DD 0

counter DD 0 ; numara evenimentele de tip timer
time DD 0
arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

frog_j DD 320
frog_k DD 12

frog_x DD 199
frog_y DD 600

score DD 0
tmp DD 0

button1_x EQU 619
button1_y EQU 448
button2_x EQU 679
button2_y EQU 508
button3_x EQU 559
button3_y EQU 508
button_size EQU 60

itsover DD 0

part_width EQU 16
part_height EQU 16

symbol_width EQU 10
symbol_height EQU 20

width2 EQU 30
height2 EQU 30

arrow_width EQU 40
arrow_height EQU 40

frog_width EQU 40
frog_height EQU 40

map_size_width EQU 90
map_size_height EQU 16

movement EQU 10
motion DD 0 ;incepe de la motion si afiseaza movement bucati 
include digits.inc
include letters.inc
include frogs.inc
include arrows.inc ;game_map+24 accesez si retin intr-un registru, apoi voi face game_map+24 = game_map+23
include lett.inc

game_map    DB  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DB  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DB  1,1,1,1,1,1,4,1,4,1,1,1,1,1,4,1,1,4,1,1,1,1,1,4,1,1,4,1,1,1
			db  4,1,1,4,4,1,1,4,1,4,1,1,1,1,1,1,1,1,1,1,1,4,1,4,1,1,1,1,1,4
			db  1,1,4,1,1,1,1,1,4,1,1,4,1,1,1,4,1,1,1,4,1,1,4,1,4,1,1,1,1,1
            DB  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
			db  4,1,1,4,1,1,1,4,1,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
			db  1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,1,1,1,4,1,1,4,1,4,1,1,1,1,1
            DB  1,1,1,1,1,4,1,1,1,1,1,1,1,1,1,1,1,1,1,4,1,1,1,1,1,1,1,1,1,1
			db  4,1,1,1,1,1,1,4,1,4,1,1,1,1,1,1,1,1,1,1,4,1,1,1,1,1,1,1,1,1
			db  1,1,1,1,4,1,1,1,1,1,1,1,1,1,1,4,1,1,1,4,1,1,4,1,4,1,1,1,1,1
            DB  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DB  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DB  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DB  3,3,3,5,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,5,3,5,3,3
			db  3,3,3,3,3,3,3,3,3,3,3,3,5,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3
			db  3,5,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,5,3,3,3,3,3,3
            DB  3,3,3,3,3,3,3,3,5,3,3,5,3,3,3,3,3,5,3,3,3,3,5,3,3,3,3,3,3,3
			db  3,3,3,3,3,3,3,5,3,3,3,3,5,3,3,3,3,3,5,3,3,3,3,3,3,3,5,3,3,3
			db  3,5,3,3,3,3,3,3,5,3,3,3,3,3,5,3,3,3,3,3,5,3,3,3,3,3,3,3,3,3
            DB  3,5,3,5,3,3,3,3,3,3,3,3,3,3,3,3,3,5,3,3,3,3,3,3,5,3,3,5,3,3
			db  3,3,3,3,3,3,3,3,3,3,3,5,3,3,3,3,5,3,3,3,3,3,5,3,3,3,3,3,5,3
			db  5,3,3,3,3,3,5,3,3,3,5,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,5
            DB  1,1,1,1,4,1,4,1,1,1,1,1,1,4,1,1,1,1,1,1,1,1,1,1,1,1,1,1,4,1
			db  4,1,1,1,1,1,1,4,1,4,1,1,1,1,4,1,1,1,1,4,1,4,1,1,1,1,1,1,4,1
			db  1,1,1,1,1,1,1,1,1,1,1,1,1,4,1,4,1,1,1,1,1,1,4,1,4,1,1,1,1,4
            DB  1,1,1,1,1,1,4,1,1,4,1,1,1,1,1,1,4,1,1,1,1,1,1,1,1,1,1,1,1,1
			db  4,1,1,4,1,1,1,4,1,4,1,1,1,1,4,1,1,1,1,4,1,4,1,1,1,1,1,1,4,1
			db  1,1,1,1,1,1,1,1,1,1,1,1,1,4,1,4,1,1,1,1,1,1,4,1,4,1,1,1,1,4
            DB  1,1,1,1,1,1,1,1,1,1,4,1,1,4,1,4,1,1,4,1,4,1,1,1,4,1,1,1,1,1
			db  4,1,1,1,4,1,1,4,1,4,1,1,1,1,4,1,1,1,1,4,1,4,1,1,1,1,1,1,4,1
			db  1,1,1,1,1,1,1,1,1,1,1,1,1,4,1,4,1,1,1,1,1,1,4,1,4,1,1,1,1,4
            DB  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            DB  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
			db  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
            
	; game_map DB 4,5,3
			 ; DB 5,4,1
			 ; DB 0,5,4
; game_map   	DB 0,0,0,0,0,0,0,0,0,0
			; DB 3,3,3,5,5,3,3,5,3,3
			; DB 3,5,3,3,5,5,5,3,5,3
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 1,4,1,1,4,1,1,1,1,4
			; DB 1,1,4,1,4,1,1,1,4,1
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 3,3,3,5,5,3,3,5,3,3
			; DB 3,5,3,3,5,5,5,3,5,3
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 1,4,4,1,4,1,1,1,1,4
			; DB 1,1,1,4,1,4,1,1,4,1
			; DB 0,0,0,0,0,0,0,0,0,0
			; DB 0,0,0,0,0,0,0,0,0,0
		 


.code
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y
make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
	
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

make_text2 proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	lea esi,lett
	
draw_text:
	mov ebx, width2
	mul ebx
	mov ebx, height2
	mul ebx
	add esi, eax
	mov ecx, height2
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, height2
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, width2
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text2 endp

make_frog proc
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
lea esi, frogs

	
draw_text:
	mov ebx, frog_width
	mul ebx
	mov ebx, frog_height
	mul ebx
	add esi, eax
	mov ecx, frog_height
		
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, frog_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, frog_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	cmp byte ptr [esi], 5
	je simbol_pixel_albastru
	cmp byte ptr [esi], 3
	je simbol_pixel_negru
	cmp byte ptr [esi], 4
	je simbol_pixel_maro
	cmp byte ptr [esi], 2
	je simbol_pixel_verde
	cmp byte ptr [esi], 6
	je simbol_pixel_rosu
	cmp byte ptr [esi], 7
	je simbol_pixel_gri
	cmp byte ptr [esi], 1
	je simbol_pixel_verde_inchis
	
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
	jmp simbol_pixel_next
simbol_pixel_negru:
    mov dword ptr [edi], 0000000h
    jmp simbol_pixel_next	
simbol_pixel_albastru:
	mov dword ptr [edi], 00EF9FCh
	jmp simbol_pixel_next
simbol_pixel_verde:
    mov dword ptr [edi], 027FF00h
	jmp simbol_pixel_next
simbol_pixel_rosu:
    mov dword ptr [edi], 0EA320Dh
	jmp simbol_pixel_next
simbol_pixel_gri:
    mov dword ptr [edi], 0BDB7B6h
	jmp simbol_pixel_next
simbol_pixel_verde_inchis:
    mov dword ptr [edi], 0268A0Fh	
	jmp simbol_pixel_next
simbol_pixel_maro:
    mov dword ptr [edi], 0BF951Ch
	jmp simbol_pixel_next	
    	
	
simbol_pixel_next:
	inc esi
	add edi, 4
	dec ecx
	cmp ecx,0
	jne bucla_simbol_coloane
	;loop bucla_simbol_coloane
	pop ecx
	dec ecx
	cmp ecx,0
	jne bucla_simbol_linii
	;loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_frog endp	

make_arrows proc
push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
lea esi, arrows

	
draw_text:
	mov ebx, arrow_width
	mul ebx
	mov ebx, arrow_height
	mul ebx
	add esi, eax
	mov ecx, arrow_height
		
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, arrow_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, arrow_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 6
	je simbol_pixel_galben
	cmp byte ptr [esi], 5
	je simbol_pixel_albastru
	cmp byte ptr [esi], 1
	je simbol_pixel_negru
	cmp byte ptr [esi], 4
	je simbol_pixel_maro
	cmp byte ptr [esi], 2
	je simbol_pixel_verde
	cmp byte ptr [esi], 0
	je simbol_pixel_rosu
	cmp byte ptr [esi], 7
	je simbol_pixel_gri
	cmp byte ptr [esi], 3
	je simbol_pixel_mov
	
simbol_pixel_mov:
	mov dword ptr [edi], 07A15CAh
	jmp simbol_pixel_next
simbol_pixel_negru:
    mov dword ptr [edi], 0000000h
    jmp simbol_pixel_next	
simbol_pixel_albastru:
	mov dword ptr [edi], 00EF9FCh
	jmp simbol_pixel_next
simbol_pixel_verde:
    mov dword ptr [edi], 027FF00h
	jmp simbol_pixel_next
simbol_pixel_rosu:
    mov dword ptr [edi], 0EA320Dh
	jmp simbol_pixel_next
simbol_pixel_gri:
    mov dword ptr [edi], 0BDB7B6h
	jmp simbol_pixel_next
simbol_pixel_galben:
    mov dword ptr [edi], 0FCF81Fh	
	jmp simbol_pixel_next
simbol_pixel_maro:
    mov dword ptr [edi], 0BF951Ch
	jmp simbol_pixel_next	
    	
	
simbol_pixel_next:
	inc esi
	add edi, 4
	dec ecx
	cmp ecx,0
	jne bucla_simbol_coloane
	;loop bucla_simbol_coloane
	pop ecx
	dec ecx
	cmp ecx,0
	jne bucla_simbol_linii
	;loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_arrows endp	

line_horizontal macro x,y,len,color
local bucla_linie
    mov eax,y
	mov ebx,area_width
	mul ebx
	add eax,x
	shl eax,2
	add eax,area
	mov ecx,len
bucla_linie: 
    mov dword ptr[eax], color
    add eax,4
    loop bucla_linie
endm	

line_vertical macro x,y,len,color
local bucla_coloana
    mov eax,y
	mov ebx,area_width
	mul ebx
	add eax,x
	shl eax,2
	add eax,area
	mov ecx,len	
bucla_coloana: 
    mov dword ptr[eax], color
    add eax, area_width *4
    loop bucla_coloana
endm	
; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm

make_text2_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text2
	add esp, 16
endm

make_frog_macro macro symbol,drawArea,x,y
    push y
	push x
	push drawArea
	push symbol
	call make_frog
	add esp, 16
endm

make_arrows_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_arrows
	add esp, 16
endm


matrix proc
push ebp
mov ebp,esp
pusha

lea esi,game_map
add esi,motion
mov ecx,map_size_height
mov ebx,0
mov edi,0
bucla_symbol_linii:
push ecx
mov ecx,movement
bucla_symbol_coloane:
cmp byte ptr [esi], 0
je campie
cmp byte ptr [esi], 3
je road
cmp byte ptr [esi], 5
je car
cmp byte ptr [esi], 1
je water
cmp byte ptr [esi], 4
je bustean

campie:
make_frog_macro 0,area,ebx,edi
jmp continue
water:
make_frog_macro 2,area,ebx,edi
jmp continue
bustean:
make_frog_macro 4,area,ebx,edi
jmp continue
road:
make_frog_macro 1,area,ebx,edi
jmp continue
car:
make_frog_macro 3,area,ebx,edi
jmp continue

continue: 
add ebx,frog_width
inc esi
dec ecx
cmp ecx,0
jne bucla_symbol_coloane
pop ecx
mov ebx,0
add edi,frog_height
add esi,map_size_width
sub esi,movement
dec ecx
cmp ecx,0
jne bucla_symbol_linii
popa
mov esp,ebp
pop ebp
ret
matrix endp

matrice_macro macro
call matrix
endm

; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	cmp itsover,1
	je final_draw
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	jmp afisare_litere
	
evt_click:
	mov edi, area
	mov ecx, area_height
	mov ebx, [ebp+arg3]
	and ebx, 7
	inc ebx
	;line_horizontal [ebp+arg2],[ebp+arg3], 30, 0FFh
	;line_vertical [ebp+arg2],[ebp+arg3], 30, 0FFh
	mov eax, [ebp+arg2]
	cmp eax, button1_x
	jl buton2
	cmp eax,button1_x + button_size
	jg buton2
	mov eax, [ebp+arg3]
	cmp eax,button1_y
	jl buton2
	cmp eax,button1_y + button_size
	jg buton2
	;s-a dat click pe buton
	;jmp move
	mov edx,frog_y
	cmp edx,130
	jl game_over
	sub edx,40
	sub frog_y,40
	make_frog_macro 5,area,frog_x,frog_y
	mov eax,edx
	add eax,20
	mov eax,score
	inc score
	buton2:
			mov eax, [ebp+arg2]
			cmp eax, button2_x
			jl buton3
			cmp eax,button2_x + button_size
			jg buton3
			mov eax, [ebp+arg3]
			cmp eax,button2_y
			jl buton3
			cmp eax,button2_y + button_size
			jg buton3
			mov edx,frog_y
			cmp edx,130
			jl game_over
			mov ebx,frog_x
			add ebx,40
			add frog_x,40
			make_frog_macro 5,area,frog_x,frog_y
			; mov eax,edx
			; add eax,20
			; mov eax,score
			; inc score
	buton3:
			mov eax, [ebp+arg2]
			cmp eax, button3_x
			jl button_fail
			cmp eax,button3_x + button_size
			jg button_fail
			mov eax, [ebp+arg3]
			cmp eax,button3_y
			jl button_fail
			cmp eax,button3_y + button_size
			jg button_fail
			mov edx,frog_y
			cmp edx,130
			jl game_over
			mov ebx,frog_x
			sub ebx,40
			sub frog_x,40
			make_frog_macro 5,area,frog_x,frog_y
			; mov eax,edx
			; add eax,20
			; mov eax,score
			; inc score		
	; mov edx,frog_y
	; cmp edx,130
	; jl game_over
	; sub edx,40
	; sub frog_y,40
	; make_frog_macro 5,area,frog_x,frog_y
	; mov eax,edx
	; add eax,20
	; mov eax,score
	; inc score
	button_fail:
		jmp afisare_litere
	game_over:
	
	    
	    make_text_macro 'G', area, 700, 100
		make_text_macro 'A', area, 710, 100
		make_text_macro 'M', area, 720, 100
		make_text_macro 'E', area, 730, 100
		
		make_text_macro 'O', area, 740, 100
		make_text_macro 'V', area, 750, 100
		make_text_macro 'E', area, 760, 100
		make_text_macro 'R', area, 770, 100
		
		mov itsover,1 ;variabila game_over daca e 1 sau 0 atunci 
	; stop:
		; mov eax,0
		; mov counter,eax
		; jmp final_draw

collision:
		
		
evt_timer:
	inc counter
	mov eax,counter
	mov ebx,2
	mov edx,0
	div ebx
	cmp edx,0
	jne final_draw
	; cmp ecx,4
	; je loop_nr
		 ;impartire la un numar si verificam restul 
		mov eax,motion
		mov ebx,map_size_width
		sub ebx,movement
		inc ebx
		cmp eax,ebx
		je initial
		inc motion
		jmp afisare_litere
	  ; loop_nr: 
	  ; inc motion
	  ; mov counter,0
	; inc counter
	; mov eax,counter
	; mov edx,4
	; div edx
	; cmp edx,0
	; je timing
	;mov counter,eax
	; mov eax,motion
	; mov ebx,map_size_width
	; sub ebx,movement
	; inc ebx
	; cmp eax,ebx
	; je initial
	; inc motion
	; jmp afisare_litere
; timing:	
	; inc time	
initial:
    mov eax,0
	mov motion,eax
	jmp afisare_litere
	
;incr:
		
	; mov eax,map_size_width
	; mov ebx,3
	; mul ebx
	; dec eax
	; mov tmp,eax
	; dec eax
	; mov esi,[eax]
	; mov edi,[tmp]
	; mov ecx,map_size_width
	; dec ecx
	; std
	; rep movsb
	; cld
	; mov ebx,tmp
	; mov dword ptr [edi], ebx

	
afisare_litere:
	;afisam valoarea counter-ului curent (sute, zeci si unitati)
	make_text_macro 'S',area,500,50
	make_text_macro 'C',area,510,50
	make_text_macro 'O',area,520,50
	make_text_macro 'R',area,530,50
	mov ebx, 10
	mov eax, counter
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 30, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 20, 10
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 10, 10
	
afisare_scor:
    mov ebx, 10
	mov eax, score
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 570, 50
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 560, 50
	;cifra sutelor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 550, 50
  	
	
	;scriem un mesaj
	make_text2_macro 0, area, 600, 100
	make_text2_macro 1, area, 630, 100
	make_text2_macro 2, area, 660, 100
	make_text2_macro 3, area, 690, 100
	make_text2_macro 4, area, 720, 100
	make_text2_macro 5, area, 750, 100
	
	make_text2_macro 6, area, 750, 140
	make_text2_macro 7, area, 780, 140
	make_text2_macro 8, area, 810, 140
	make_text2_macro 9, area, 840, 140

	
	line_horizontal button2_x,button2_y,button_size,0
	line_horizontal button2_x,button2_y + button_size,button_size,0
	line_vertical button2_x,button2_y,button_size,0
	line_vertical button2_x + button_size,button2_y,button_size,0
	line_horizontal button1_x,button1_y,button_size,0
	line_horizontal button1_x,button1_y + button_size,button_size,0
	line_vertical button1_x,button1_y,button_size,0
	line_vertical button1_x + button_size,button1_y,button_size,0
	line_horizontal button3_x,button3_y,button_size,0
	line_horizontal button3_x,button3_y + button_size,button_size,0
	line_vertical button3_x,button3_y,button_size,0
	line_vertical button3_x + button_size,button3_y,button_size,0
	; mov eax,button_x
	; sub eax,15
	; mov ebx,button_y
	; sub ebx,15
	make_arrows_macro 0,area,button1_x+10,button1_y+10
	make_arrows_macro 1,area,button3_x+10,button3_y+10
	make_arrows_macro 2,area,button2_x+10,button2_y+10
	
	matrice_macro
	make_frog_macro 5, area, frog_x, frog_y
final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	
	;terminarea programului
	push 0
	call exit
end start
