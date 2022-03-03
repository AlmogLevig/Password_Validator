# VALIDATION PASSWORD SCRIPT
#!/bin/bash

#################### Color Printing Function ############################
# After using Password Validation Function, the script will be run this
# function. The function using a single parameter then the output is
# password is passed or not. 
# Green color -> the password passed the validation; pwsdValidation = 1
# Red color -> the password didn't passed the validation; pwsdValidation = 0
#########################################################################
function colorPrinting {
    if [ $pwsdValidation -eq 1 ]
    then # True
        echo -e "\e[32m$pswd\e[0m"
    else # false
        echo -e "\e[31m$pswd\e[0m"
        failedMessages
    fi
}

##################### Validation failed Massages ########################  
# This function print failes error masseges, this function is activate
# only if password didn't passed validation test.
#########################################################################
function failedMessages {
    echo "###############################################################"
    if [ $lengthReq -eq 0 ]
    then
        echo "* The Password is too short (${len} char.) need at least 10 characters"
    fi
    
    if [ $upperReq -eq 0 ]
    then
        echo "* The password does not Contain an uppercase"
    fi

    if [ $lowercaseReq -eq 0 ]
    then
        echo "* The password does not Contain a lowercase letter"
    fi

    if [ $numberReq -eq 0 ]
    then
        echo "* The password does not Contain a Number"
    fi
 } 

#################### Password Validation Function #######################
# This fuction will check if the password meets the requirements below:
# 1) Length -  the password contain at least 10 characters 
# 2) Uppercase - the password contain at least uppercase
# 3) Lowercase - the password contain at least one lowercase
# 4) Number - the password contain at least one number
#########################################################################
function passwordValidation () {
    # Check length of the password
    len=${#pswd}
    if [ $len -ge  10 ]
    then # True
        lengthReq=1
    else # False
        lengthReq=0
    fi
    
    # Check if The password contain Uppercase
    UPPERCASE="ABCDEFGHIJKMLNOPQRSTUVWXYZ"
    if [[ "$pswd" =~ [$UPPERCASE] ]]
    then # True
        upperReq=1
    else # False
        upperReq=0
    fi
    
    # Check if The password contain Lowercase
    LOWERCASE="abcdefghijklmnopqrstuvwxyz"
    if [[ "$pswd" =~ [$LOWERCASE] ]]
    then # True
        lowercaseReq=1
    else # False
        lowercaseReq=0
    fi
    
    # Check if The password contain numbers
    NUMBER="0123456789"
    if [[ "$pswd" =~ [$NUMBER] ]]
    then # True
        numberReq=1 
    else # False
        numberReq=0
    fi
    
    # If statement check if the password is validate
    if [[ $lengthReq -eq 1 && $upperReq -eq 1 && \
        $lowercaseReq -eq 1 && $numberReq -eq 1 ]] 
    then # Pass
        pwsdValidation=1
    else # Not Pass 
        pwsdValidation=0
    fi
    
    # Finally, Calling to printing function
    colorPrinting
}

################### Start Point #######################
# # while loop for detect between -f to simple string
#######################################################
while :; do
case $1 in
    -f)
    pswd=$(< $2)
    # Call Password Validation Function
    passwordValidation $pswd
    ;;
    *)
       pswd=${1}
        # Call Password Validation Function
        passwordValidation $pswd  
    ;;
esac
done
exit 1