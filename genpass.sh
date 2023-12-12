#!/bin/bash

# RESTAGA O CAMINHO COMPLETO PARA O SCRIPT
ROOT="$(cd "$(dirname "$0")" && pwd)"

# EXIBE A TELA EM AMBIENTE GRÁFICO PEDINDO AS CONFIGURAÇÕES PARA AS SENHAS
DATA=$(
	yad --form \
	--center \
	--fixed \
	--borders=10 \
	--window-icon=$ROOT/key.svg \
	--title "GENPASS" \
	--align=right \
	--field "Length (6-2048):NUM" "64!6..2048!1"\
	--field "Count (1-128):NUM" "1!1..128!1"
)

# FINALIZA O SCRIPT SE NÃO FOR ESCOLHIDA A OPÇÃO OK
if [ "$DATA" == "" ]; then
	exit 0
fi

# RESGATA O TAMANHO REQUISITADO PARA AS SENHAS
PASSWORDS_SIZE=$(echo $DATA | cut -f1 -d'|')

# RESGATA O NÚMERO REQUISITADO DE SENHAS
PASSWORDS_COUNT=$(echo $DATA | cut -f2 -d'|')

# DEFINE A LISTA DE CARACTERES UTILIZADOS NA GERAÇÃO DAS SENHAS
CHARACTERS='_-,;:!?..·'\''"()[]{}§@*/\&#%`^¨°+<=>¬|~─¢$£01¹2²3³456789aAªáÁàÀâÂäÄãÃbBcCçÇdDeEéÉèÈêÊëËfFgGhiIíÍìÌîÎïÏjJJkKlLmMnNoOºóÓòÒôÔöÖõÕpPqQrRsStTuUúÚùÙûÛüÜvVwWxXyYzZ'

# RESGATA O TAMANHO DA LISTA DE CARACTERES
TOTAL_CHARACTERS=${#CHARACTERS}

# CASO O TAMANHO DA SENHA SEJA MAIOR QUE A LISTA DE CARACTERES...
if [ $PASSWORDS_SIZE -gt $TOTAL_CHARACTERS ]; then

	# CALCULA O NÚMERO DE VEZES QUE A LISTA DEVE SER REPETIDA PARA AGRANGER O
	# TAMANHO FINAL
	TIMES_TO_REPEAT=$((( $PASSWORDS_SIZE + ( $TOTAL_CHARACTERS - 1 ) ) / $TOTAL_CHARACTERS ))

	# REPETE A LISTA DE CARACTERES O NÚMERO DE VEZES NECESSÁRIAS
	CHARACTERS=$(yes $CHARACTERS | head -$TIMES_TO_REPEAT | tr -d '\n')

fi

# INICIALIZA A LISTA DE SENHAS
PASSWORDS=''

# AJUSTA O TAMANHO DAS SENHAS
(( PASSWORDS_SIZE-- ))

# ENQUANTO O NÚMERO DE SENHAS REQUISITADAS FOR MAIOR QUE ZERO...
while [ $PASSWORDS_COUNT -gt 0 ]; do

	# GERA A SENHA
	PASSWORD=$(echo $CHARACTERS | grep -o . | shuf -n$PASSWORDS_SIZE | tr -d '\n')

	# ADICIONA NA LISTA DE SENHAS
	PASSWORDS+="$PASSWORD"$'\n'

	# DECREMENTA O NÚMERO DE SENHAS EM 1
	(( PASSWORDS_COUNT-- ))

done

# EXIBE A TELA EM AMBIENTE GRÁFICO COM A LISTA DE SENHAS GERADAS
DATA=$(
	echo "${PASSWORDS::-1}" | yad --list \
	--no-markup \
	--center \
	--width=800 \
	--height=600 \
	--borders=10 \
	--window-icon=$ROOT/key.svg \
	--title "GENPASS" \
	--text="Double click to copy password" \
	--column="Password:TEXT"
)

# FINALIZA O SCRIPT SE NÃO FOR ESCOLHIDA A OPÇÃO OK
if [ "$DATA" == "" ]; then
	exit 0
fi

# COPIA A SENHA ESCOLHIDA PARA A ÁREA DE TRANSFERÊNCIA
echo $DATA | xclip -selection clipboard -in
