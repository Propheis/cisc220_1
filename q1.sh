#!/bin/bash

mode="number" #options are number, operator, execute

total="None"
number="None"
operator="None"

function get_number() {
    num="None"
    int_regex=^-?[0-9]+$

    while ! [[ "$num" =~ $int_regex ]]; do
	read -p "Please enter a number: " num

	if [[ $num == ":q" ]]; then
	    echo "Thanks for using my calculator"
	    exit 0
	elif ! [[ $num =~ $int_regex ]]; then
	    echo "Error! Please insert a number"
	fi
	
    done
    number=$num
}

function get_operator() {
    op="None"
    op_regex=^[+/*\-]{1}$

    while ! [[ "$op" =~ $op_regex ]]; do
	read -p "Please enter an operator: " op

	if [[ $op == ":q" ]]; then
	    echo "Thanks for using my calculator"
	    exit 0
        elif ! [[ $op =~ $op_regex ]]; then
	    echo "Error! Please insert an operator"
	fi
    done
    operator=$op
}

function get_next_values() {
    while [[ $number == "None" || $operator == "None" ]]; do
	if [[ $mode == "operator" ]]; then
	    get_operator
	    mode="number"
        elif [[ $mode == "number" ]]; then
	    get_number
	    mode="operator"
	fi
    done
    mode="execute"
}

function calculate_total() {
    case $operator in
	"+") total=$(($total+$number));;
	"-") total=$(($total-$number));;
	"*") total=$(($total*$number));;
	"/") total=$(($total/$number));;
	*)   echo "Something went horribly wrong"
    esac
}

while (true); do
    if [[ $total == "None" ]]; then  # Should only happen once
	get_number
	total=$number
	number="None"
	mode="operator"
	get_next_values
    elif [[ $mode != "execute" ]]; then
	get_next_values
    fi

    calculate_total

    number="None"
    operator="None"
    mode="operator"

    echo "The new total is $((total))"
done

