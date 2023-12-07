#!/bin/bash
ROOT="$(cd "$(dirname "$0")" && pwd)"
DATA=$(
	yad --fontname="Fira Code" \
	--form \
	--center \
	--fixed \
	--borders=10 \
	--window-icon=$ROOT/key.svg \
	--title "GENPASS" \
	--align=right \
	--field "Length (6-2048):NUM" "64!6..2048!1"\
	--field "Count (1-128):NUM" "1!1..128!1"
)
if [ "$DATA" == "" ]; then
	exit 0
fi
PASSWORDS_SIZE=$(echo $DATA | cut -f1 -d'|')
PASSWORDS_COUNT=$(echo $DATA | cut -f2 -d'|')
CHARACTERS='!"#%&'\''()*+,-./:;<=>?@[\]^_`{|}~¨$0123456789AaÁáÀàÂâÄäÃãBbCcÇçDdEeÉéÈèÊêËëFfGghIiÍíÌìÎîÏïJJjKkLlMmNnOoÓóÒòÔôÖöÕõPpQqRrSsTtUuÚúÙùÛûÜüVvWwXxYyZz'
PASSWORDS=''
while [ $PASSWORDS_COUNT -gt 0 ]
do
	PASSWORD=$(echo $CHARACTERS | grep -o . | shuf -n$PASSWORDS_SIZE | tr -d '\n')
	PASSWORDS+="$PASSWORD"$'\n'
	((PASSWORDS_COUNT--))
done
DATA=$(
	echo "${PASSWORDS::-1}" | yad --fontname="Fira Code" \
	--width=600 \
	--height=400 \
	--no-markup \
	--borders=10 \
	--window-icon=$ROOT/key.svg \
	--title "GENPASS" \
	--center \
	--list \
	--text="Double click to copy password" \
	--column="Password:TEXT" \
	--button=gtk-cancel:0 \
	--button=gtk-ok:1
)
if [ "$DATA" == "" ]; then
	exit 0
fi
echo $DATA | xclip -selection clipboard -in
