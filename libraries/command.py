##################################################################################################################################
# Autor: Jhonattan Gomes
# Decrição: Métodos de execução via linha de comando
##################################################################################################################################
import os

##################################################################################################################################
# Autor: Jhonattan Gomes
# Descrição: Executa um comando robot no console.
##################################################################################################################################
def run_command_lines(cmd):
    directories = os.system(cmd)
    print(directories)