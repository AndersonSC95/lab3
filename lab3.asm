.data
vector:    .word 50, -50, -30, 30, 5, -1, 9, 0, 4, -8, 12, -6, -15, 1, -2, 13, -17, 11, 6, -9, 16, -11, 8, -4, 14
max_par:   .word 0
min_par:   .word 0
max_impar: .word 0
min_impar: .word 0

    .text
    .globl main
main:
    la $t0, vector    	# Cargar la dirección base del vector en $t0
    li $t1, 0          	# Inicializar el índice del vector a 0
    li $t2, -100      	# Inicializar el máximo con un valor pequeño
    li $t3, 100        	# Inicializar el mínimo con un valor grande
    li $s0, 25        	# Cargar el valor de 25 (cantidad de elementos en el vector)


loop:    
    lw $t4, 0($t0)      # Cargar el número actual del vector
    addi $t0, $t0, 4    # Incrementar la dirección del vector en 4 bytes
    addi $t1, $t1, 1    # Incrementar el índice del vector en 1

    andi $t5, $t1, 1    # Verificar si el índice es par o impar
    beqz $t5, par       # Saltar a 'par' si el resultado es cero (índice par)

    slt $t6, $t4, $t3   # Comprobar si el número actual es menor que el mínimo impar
    bnez $t6, update_min_impar   # Saltar a 'update_min_impar' si el resultado no es cero

    slt $t7, $t2, $t4   # Comprobar si el número actual es mayor que el máximo impar
    bnez $t7, update_max_impar   # Saltar a 'update_max_impar' si el resultado no es cero

    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteración

par:
    slt $t6, $t4, $t3   # Comprobar si el número actual es menor que el mínimo par
    bnez $t6, update_min_par     # Saltar a 'update_min_par' si el resultado no es cero

    slt $t7, $t2, $t4   # Comprobar si el número actual es mayor que el máximo par
    bnez $t7, update_max_par     # Saltar a 'update_max_par' si el resultado no es cero

next_iteration:
    bne $t1, $s0, loop  # Saltar a 'loop' si el índice no alcanzó la cantidad de elementos
    j end_program       # Saltar a 'end_program' para finalizar el programa

update_min_par:
    move $s1, $t4       # Actualizar el mínimo par
    move $t3, $t4
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteración

update_max_par:
    move $s2, $t4       # Actualizar el máximo par
    move $t2, $t4
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteración

update_min_impar:
    move $s3, $t4       # Actualizar el mínimo impar
    move $t3, $t4
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteración

update_max_impar:
    move $s4, $t4       # Actualizar el máximo impar
    move $t2, $t4
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteración

end_program:
    sw $s1, min_par     # Almacenar el máximo par en memoria
    sw $s2, max_par     # Almacenar el mínimo par en memoria
    sw $s3, min_impar  	# Almacenar el máximo impar en memoria
    sw $s4, max_impar   # Almacenar el mínimo impar en memoria

    li $v0, 10          # Cargar el código de terminación del programa
    syscall             # Finalizar el programa
