.data
vector:    .word 50, -50, -30, 30, 5, -1, 9, 0, 4, -8, 12, -6, -15, 1, -2, 13, -17, 11, 6, -9, 16, -11, 8, -4, 14
max_par:   .word 0
min_par:   .word 0
max_impar: .word 0
min_impar: .word 0

    .text
    .globl main
main:
    la $t0, vector    	# Cargar la direcci�n base del vector en $t0
    li $t1, 0          	# Inicializar el �ndice del vector a 0
    li $t2, -100      	# Inicializar el m�ximo con un valor peque�o
    li $t3, 100        	# Inicializar el m�nimo con un valor grande
    li $s0, 25        	# Cargar el valor de 25 (cantidad de elementos en el vector)


loop:    
    lw $t4, 0($t0)      # Cargar el n�mero actual del vector
    addi $t0, $t0, 4    # Incrementar la direcci�n del vector en 4 bytes
    addi $t1, $t1, 1    # Incrementar el �ndice del vector en 1

    andi $t5, $t1, 1    # Verificar si el �ndice es par o impar
    beqz $t5, par       # Saltar a 'par' si el resultado es cero (�ndice par)

    slt $t6, $t4, $t3   # Comprobar si el n�mero actual es menor que el m�nimo impar
    bnez $t6, update_min_impar   # Saltar a 'update_min_impar' si el resultado no es cero

    slt $t7, $t2, $t4   # Comprobar si el n�mero actual es mayor que el m�ximo impar
    bnez $t7, update_max_impar   # Saltar a 'update_max_impar' si el resultado no es cero

    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteraci�n

par:
    slt $t6, $t4, $t3   # Comprobar si el n�mero actual es menor que el m�nimo par
    bnez $t6, update_min_par     # Saltar a 'update_min_par' si el resultado no es cero

    slt $t7, $t2, $t4   # Comprobar si el n�mero actual es mayor que el m�ximo par
    bnez $t7, update_max_par     # Saltar a 'update_max_par' si el resultado no es cero

next_iteration:
    bne $t1, $s0, loop  # Saltar a 'loop' si el �ndice no alcanz� la cantidad de elementos
    j end_program       # Saltar a 'end_program' para finalizar el programa

update_min_par:
    move $s1, $t4       # Actualizar el m�nimo par
    move $t3, $t4
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteraci�n

update_max_par:
    move $s2, $t4       # Actualizar el m�ximo par
    move $t2, $t4
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteraci�n

update_min_impar:
    move $s3, $t4       # Actualizar el m�nimo impar
    move $t3, $t4
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteraci�n

update_max_impar:
    move $s4, $t4       # Actualizar el m�ximo impar
    move $t2, $t4
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteraci�n

end_program:
    sw $s1, min_par     # Almacenar el m�ximo par en memoria
    sw $s2, max_par     # Almacenar el m�nimo par en memoria
    sw $s3, min_impar  	# Almacenar el m�ximo impar en memoria
    sw $s4, max_impar   # Almacenar el m�nimo impar en memoria

    li $v0, 10          # Cargar el c�digo de terminaci�n del programa
    syscall             # Finalizar el programa
