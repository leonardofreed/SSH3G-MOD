#!/bin/bash
fun_exp () {
(
for _user in $(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody); do
   if [[ $(chage -l $_user |grep "Account expires" |awk -F ': ' '{print $2}') != never ]]; then
       [[ $(date +%s) -gt $(date '+%s' -d"$(chage -l $_user |grep "Account expires" |awk -F ': ' '{print $2}')") ]] && userexp=$(expr $userexp + 1)
   fi
   [[ userexp == [0-9] ]] && userexp=0$userexp
done
echo "$userexp" > /etc/CrashVPN/Exp
) &
}
fun_exp > /dev/null 2>&1
