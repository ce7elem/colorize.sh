#!/bin/bash

API_KEY=ef5706a8-2b09-483b-8214-f02073c03f4c

# check dependencies & shell interpreter
command -v curl >/dev/null 2>&1 || { echo -e >&2 "colorize.sh needs curl. Aborting. \nrun \"apt install curl\" (or \"brew install curl\" on macos) to install it"; exit 1; }
command -v jq >/dev/null 2>&1 || { echo -e >&2 "colorize.sh needs jq.  Aborting. \nrun \"apt install jq\" (or \"brew install jq\" on macos) to install it"; exit 1; }


if [ $# -eq 0 ]; then
    echo "usage :"
    echo "	colorize.sh path/to/picture"
    exit 1
fi

#retrive path, portable editions
canonicalize_path() {
    if [ -d "$1" ]; then
        _canonicalize_dir_path "$1"
    else
        _canonicalize_file_path "$1"
    fi
}   
_canonicalize_dir_path() {
    (cd "$1" 2>/dev/null && pwd -P) 
}           
_canonicalize_file_path() {
    local dir file
    dir=$(dirname -- "$1")
    file=$(basename -- "$1")
    (cd "$dir" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$file")
}
# path=`readlink -f "$1"`
path=`canonicalize_path "$1"`

if ! file "$path" |grep -qE 'image|bitmap'; then
  echo "file $path is not an image !"
  exit 1
fi


echo -e "\ncolorizing $path...\n"


# api call
res=$(curl -s \
	-F "image=@/$path" \
	-H "api-key:$API_KEY" \
	https://api.deepai.org/api/colorizer )

url=$(echo $res | jq -r '.output_url' )

echo "The colorized output is avaliable at : $url"

# postfix menu
declare -a menu=("Download it" "Open in browser" "Quit")
cur=0

draw_menu() {
	for i in "${menu[@]}"; do
		if [[ ${menu[$cur]} == $i ]]; then
			tput setaf 2; echo " > $i"; tput sgr0
		else
			echo "   $i";
		fi
	done
}

clear_menu()  {
	for i in "${menu[@]}"; do tput cuu1; done
	tput ed
}

# Draw initial Menu
draw_menu
while read -sn1 key; do # 1 char (not delimiter), silent
	# Check for enter/space
	if [[ "$key" == "" ]]; then break; fi

	# catch multi-char special key sequences
	read -sn1 -t 0.001 k1; read -sn1 -t 0.001 k2; read -sn1 -t 0.001 k3
	key+=${k1}${k2}${k3}

	case "$key" in
		# cursor up, left: previous item
		i|j|$'\e[A'|$'\e0A'|$'\e[D'|$'\e0D') ((cur > 0)) && ((cur--));;
		# cursor down, right: next item
		k|l|$'\e[B'|$'\e0B'|$'\e[C'|$'\e0C') ((cur < ${#menu[@]}-1)) && ((cur++));;
		# home: first item
		$'\e[1~'|$'\e0H'|$'\e[H')  cur=0;;
		# end: last item
		$'\e[4~'|$'\e0F'|$'\e[F') ((cur=${#menu[@]}-1));;
		 # q, carriage return: quit
		q|''|$'\e')echo "Aborted." && exit;;
	esac
	# Redraw menu
	clear_menu
	draw_menu
done

case $cur in
	0 ) 
		echo "Downloading..."
		curl -s $url > ${1%.*}_colorized.${1##*.}
		exit;;
	1 ) 
		# open  with default browser
		command -v x-www-browser >/dev/null 2>&1 && { x-www-browser "$url" ; exit; }
		command -v open >/dev/null 2>&1 && { open "$url" ; exit; }
		exit;;
	2 ) exit;;
esac
