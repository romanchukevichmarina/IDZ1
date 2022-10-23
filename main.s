	.intel_syntax noprefix          #
	.text                           # Начало секции
	.local	A                       # Объявляем символ A, но не экспортируем его
	.comm	A,4000000,32            # Неинициализированный массив
	.local	B                       # Объявляем символ B, но не экспортируем его
	.comm	B,4000000,32            # Неинициализированный массив
	.section	.rodata             # .rodata
.LC0:                               # Метка `.LC0:`…
	.string	"%d"                    # .LC0: "%d"
.LC1:                               # Метка `.LC1:`…
	.string	"%d "                   # .LC1: "%d"
	.text                           # секция с кодом
	.globl	main                    # Объявляем и экспортируем вовне символ `main`
main:
	push	rbp                     # / Сохраняем rbp на стек
	mov	rbp, rsp                    # | Вместо rbp записали rsp (rbp := rsp)
	sub	rsp, 32                     # \ Сдвигаем rbp на 32 байта
	
	mov	DWORD PTR -36[rbp], edi     # rbp[-36] := edi — это первый аргумент, `argc` (rdi)
	mov	QWORD PTR -48[rbp], rsi     # rbp[-48] := rsi — это второй аргумент, `argv` (rsi)
	
	lea	rax, -16[rbp]               # rax := &(-16 на стеке) -- переменная n
	mov	rsi, rax                    # Вместо rsi записали rax (rsi := rax) - 2ой аргумент
	
	lea	rdi, .LC0[rip]              # rdi := &(строчка "&d")
	mov	eax, 0                      # eax := 0
	
	call	__isoc99_scanf@PLT      # scanf("%d", &rbp[-16])
	mov	DWORD PTR -12[rbp], 2147483647      # rbp[-12] = 2147483647 -- переменная min
	mov	DWORD PTR -4[rbp], 0                # rbp[-4] = 0 -- счетчик цикла
	jmp	.L2                                 # переход к метке .L2
.L4:
	lea	rax, -20[rbp]               # rax := &(-20 на стеке)
	mov	rsi, rax                    # Вместо rsi записали rax (rsi := rax)
	
	lea	rdi, .LC0[rip]              # rdi := &(строчка "&d")
	mov	eax, 0                      # eax := 0
	
	call	__isoc99_scanf@PLT      # scanf("%d", &rbp[-20])
	mov	eax, DWORD PTR -20[rbp]     # eax := `int t`
	mov	edx, DWORD PTR -4[rbp]      # edx := `int i`
	movsx	rdx, edx                # rdx := edx
	lea	rcx, 0[0+rdx*4]             # / rcx := rdx * 4
	lea	rdx, A[rip]                 # | rdx := &rip[A]
	mov	DWORD PTR [rcx+rdx], eax    # | [rcx + rdx] := eax
	mov	eax, DWORD PTR -20[rbp]     # \ eax := rbp[-20]
	mov	edx, DWORD PTR -4[rbp]      # edx := rbp[-4]
	movsx	rdx, edx                # rdx := edx
	lea	rcx, 0[0+rdx*4]             # / rcx := rdx * 4
	lea	rdx, B[rip]                 # | rdx := &rip[B]
	mov	DWORD PTR [rcx+rdx], eax    # | [rcx + rdx] := eax
	mov	eax, DWORD PTR -20[rbp]     # \ eax := rbp[-20]
	cmp	DWORD PTR -12[rbp], eax     # сравнить rbp[-12] и eax (это счетчик цикла и N)
	jle	.L3                         # если меньше или равно, то перейти к .L3
	mov	eax, DWORD PTR -4[rbp]      # eax := rbp[-4]
	mov	DWORD PTR -8[rbp], eax      # rbp[-8] := eax
	mov	eax, DWORD PTR -20[rbp]     # eax := rbp[-20]
	mov	DWORD PTR -12[rbp], eax     # rbp[-12] := eax
.L3:
	add	DWORD PTR -4[rbp], 1        # rbp[-4] += 1 (++i)
.L2:
	mov	eax, DWORD PTR -16[rbp]         # eax := rbp[-16] (загрузка N из стека в регистр)
	cmp	DWORD PTR -4[rbp], eax          # сравнить rbp[-4] и eax (это счетчик цикла и N)
	jl	.L4                             # если меньше, то перейти к .L3
	mov	eax, DWORD PTR -8[rbp]          # eax := `int n`
	lea	rdx, 0[0+rax*4]                 # / rdx := rax * 4
	lea	rax, B[rip]                     # | rax := &rip[B]
	mov	eax, DWORD PTR [rdx+rax]        # | eax := *(rdx + rax)
	mov	DWORD PTR -20[rbp], eax         # \ rbp[-20] := eax
	mov	eax, DWORD PTR B[rip]           # eax := &rip[B]
	mov	edx, DWORD PTR -8[rbp]          # edx := rbp[-8]
	movsx	rdx, edx                    # rdx := edx
	lea	rcx, 0[0+rdx*4]                 # / rcx := rdx * 4
	lea	rdx, B[rip]                     # | rdx := &rip[B]
	mov	DWORD PTR [rcx+rdx], eax        # | [rcx + rdx] := eax
	mov	eax, DWORD PTR -20[rbp]         # \ eax := rbp[-20]
	mov	DWORD PTR B[rip], eax           # rip[B] := eax
	mov	DWORD PTR -4[rbp], 0            # rbp[-4] = 0
	jmp	.L5                             # переход к метке .L5
.L6:
	mov	eax, DWORD PTR -4[rbp]          # edx := rbp[-4]
	lea	rdx, 0[0+rax*4]                 # rdx := rax * 4
	lea	rax, B[rip]                     # rax := &rip[B]
	mov	eax, DWORD PTR [rdx+rax]        # eax := *(rdx + rax)
	mov	esi, eax                        # Вместо esi записали eax (esi := eax)
	lea	rdi, .LC1[rip]                  # rdi := &(строчка "&d")
	mov	eax, 0                          # eax := 0
	call	printf@PLT                  # printf("%d ", &rip[B])
	add	DWORD PTR -4[rbp], 1            # rbp[-4] += 1 (++j)
.L5:
	mov	eax, DWORD PTR -16[rbp]         # eax := `int n`
	cmp	DWORD PTR -4[rbp], eax          # cmp `int j` eax
	jl	.L6                             # если меньше, то перейти к .L6
	mov	eax, 0                          # eax := 0
	leave           # / Выход из функции
	ret             # \ Выход из функции