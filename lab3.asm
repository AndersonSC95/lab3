.data
vector:    .word 2, -20, 18, -10, 5, -1, 9, 0, 4, -8, 12, -6, -15, 20, -18, 13, -17, 11, 6, -9, 16, -11, 8, -4, 14
max_par:   .word 0
min_par:   .word 0
max_impar: .word 0
min_impar: .word 0

.text
.globl main
main:
	jal inicio
	jal loop
	j end_program
	
inicio:
    la $t0, vector    	# Cargar la dirección base del vector en $t0
    li $t1, 0          	# Inicializar el índice del vector a 0
    li $t2, -100      	# Inicializar el máximo con un valor pequeño
    li $t3, 100        	# Inicializar el mínimo con un valor grande
    li $s0, 25        	# Cargar el valor de 25 (cantidad de elementos en el vector)
    jr $ra

loop:  
    lb $t4, 0($t0)      # Cargar el número actual del vector
    
    li $t8, 4   	# Cargar el valor 4 en el registro $t8
    add $t0, $t0,$t8    # Incrementar la dirección del vector en 4 bytes
    
    li $t8, 1   	# Cargar el valor 1 en el registro $t8
    add $t1, $t1, $t8    # Incrementar el índice del vector en 1

    and $t5, $t1, 1    # Verificar si el índice es par o impar
    li $t8, 0   	# Cargar el valor 0 en el registro $t8
    beq $t5, $t8, par   # Saltar a 'par' si el resultado es cero (índice par)

    slt $t6, $t4, $s3   # Comprobar si el número actual es menor que el mínimo impar
    bne $t6, $t8, update_min_impar   # Saltar a 'update_min_impar' si el resultado no es cero

    slt $t7, $s4, $t4   # Comprobar si el número actual es mayor que el máximo impar
    bne $t7, $t8, update_max_impar   # Saltar a 'update_min_impar' si el resultado no es cero

    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteración

par:
    slt $t6, $t4, $t3   # Comprobar si el número actual es menor que el mínimo par
    bne $t6, $t8, update_min_par   # Saltar a 'update_min_impar' si el resultado no es cero

    slt $t7, $t2, $t4   # Comprobar si el número actual es mayor que el máximo par    
    bne $t7, $t8, update_max_par  # Saltar a 'update_min_impar' si el resultado no es cero

next_iteration:
    bne $t1, $s0, loop  # Saltar a 'loop' si el índice no alcanzó la cantidad de elementos
    jr $ra       # Saltar a 'end_program' para finalizar el programa

update_min_par:
    add $s1, $zero, $t4  # Actualizar el mínimo par
    add $t3, $zero, $t4  # Actualizar registro
    j next_iteration    # Saltar a 'next_iteration' para continuar con la siguiente iteración

update_max_par:
    add $s2, $zero, $t4    	# Actualizar el máximo par
    add $t2, $zero, $t4		# Actualizar registro
    j next_iteration    	# Saltar a 'next_iteration' para continuar con la siguiente iteración

update_min_impar:
    add $s3, $zero,$t4       	# Actualizar el mínimo impar
    add $t3, $zero, $t4  	# Actualizar registro
    j next_iteration     	# Saltar a 'next_iteration' para continuar con la siguiente iteración

update_max_impar:
    add $s4, $zero, $t4 	# Actualizar el máximo impar
    j next_iteration    	# Saltar a 'next_iteration' para continuar con la siguiente iteración

end_program:
    sw $s1, min_par     # Almacenar el mínimo par en memoria
    sw $s2, max_par     # Almacenar el máximo par en memoria
    sw $s3, min_impar  	# Almacenar el mínimo impar en memoria
    sw $s4, max_impar   # Almacenar el máximo impar en memoria
