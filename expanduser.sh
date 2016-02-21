#! /bin/sh

export ENGINE="latex"

function piped_latex () {
    echo $2 | $ENGINE -interaction=errorstopmode expander
    cat tmplineexpander.tex >> "expanded_bash_$1"
}
export -f piped_latex

cat header.tex $1 | $ENGINE -jobname="getuser"
echo "%expanded user macros" > "expanded_bash_$1"
cat $1 | tr '\n' '\0' | xargs -0 -L 1 -I % bash -c "piped_latex $1 '%'" 