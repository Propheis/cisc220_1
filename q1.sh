#!/bin/bash

mode="number" #options are number, operator, execute

total=0
number1="None"
number2="None"
operator="None"

while (true); do
    if (($mode!="execute")); then
	echo get_input_message
    fi
    calculate_new_total
    number1="None"
    number2="None"
    operator="None"
    mode="number"

    echo "The new total is $(total)"
done

function get_input_message() {
    enter_text="Please enter a number:"
    enter_op="Please enter an operator:"
    if (($mode=="number")); then
	if (($number1=="None")); then
	    number1=read -p $enter_text
	else
	    number2=read -p $enter_text
	fi
    elif (($mode=="operator")); then
	operator=read -p $enter_op 
    fi
}

function calculate_new_total() {
    if   (($operator=="plus")); then
        total=$number1+$number2
    elif (($operator=="minus")); then
	total=$number1-$number2
    elif (($operator=="multiply")); then
	total=$number1*$number2
    else
	total=$number1/1.0*$number2 # 1.0 to ensure floating point division
    fi
}

