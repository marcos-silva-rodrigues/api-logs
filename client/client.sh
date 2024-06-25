#!/bin/bash

# Caso esteja no Windows, utilize o comando "ipconfig" para obter seu IP
# Caso esteja no Linux ou MAC, utilize "ip addr show" ou "ifconfig"
HOST='api-cursos:8080'

while true
    do

    NUMB=`expr $RANDOM % 110 + 1`
    unset UUID
    unset CURSO

    if [ $NUMB -le 20 ]; then
        curl http://${HOST}/cursos
        elif [ $NUMB -ge 21 ] && [ $NUMB -le 40 ] ; then
        curl http://${HOST}/cursos?page=0&size=3&sort=dataInscricao,DESC
        elif [ $NUMB -ge 41 ] && [ $NUMB -le 60 ] ; then
        UUID=`curl --data '{"numeroMatricula":"1234567890","numeroCurso":"0987654321","nomeCurso":"Desenvolvimento de clientes sinteticos","categoriaCurso":"Site Reliability Enginner","preRequisito":"Formação DevOps","nomeProfessor":"Kleber Costa","periodoCurso":"12 horas"}' --header "Content-Type:application/json" --request POST http://${HOST}/cursos | jq | grep '"id"' | awk -F":" '{print $2}' | sed -e s'/"//g' | sed -e s'/,//g' | sed -e s'/ //g'`
        if [ -z ${UUID} ] ; then
                UUID=`curl http://${HOST}/cursos | jq | grep id | tail -n 1 | awk -F":" '{print $2}' | sed -e s'/"//g' | sed -e s'/,//g' | sed -e s'/ //g'`
            CURSO="http://${HOST}/cursos/${UUID}"
        sleep 1.5
            curl -X DELETE "$CURSO"
            else
            CURSO="http://${HOST}/cursos/${UUID}"
            sleep 1.5
            curl --data '{"numeroMatricula":"0987654321","numeroCurso":"1234567890","nomeCurso":"Atualização de clientes sinteticos","categoriaCurso":"Site Reliability Enginner","preRequisito":"Formação DevOps","nomeProfessor":"Kleber Costa","periodoCurso":"12 horas"}' --header "Content-Type:application/json" -X PUT "$CURSO"
            sleep 1.5
            curl -X DELETE "$CURSO"
            fi
    elif [ $NUMB -ge 61 ] && [ $NUMB -le 80  ] ; then
            LINES=`curl http://${HOST}/cursos | jq | grep '"id"' | awk -F":" '{print $2}' | sed -e s'/"//g' | sed -e s'/,//g' | sed 's/ //g' | wc -l`
            NUMLN=`expr $RANDOM % ${LINES} + 1`
            SRCLN=`curl http://${HOST}/cursos | jq | grep '"id"' | awk -F":" '{print $2}' | sed -e s'/"//g' | sed -e s'/,//g' | sed 's/ //g' | head -n ${NUMLN}`
        curl http://${HOST}/cursos/${SRCLN}
        elif [ $NUMB -ge 81 ] && [ $NUMB -le 90  ] ; then
            curl http://${HOST}/cursos/1b12487c-0e99-4237-af07-4b221d05db93
        elif [ $NUMB -ge 91 ] && [ $NUMB -le 100  ] ; then
            curl -X DELETE http://${HOST}/cursos/1b12487c-0e99-4237-af07-4b221d05fb51
        else
            curl --data '{"numeroMatricula":"0987654321","numeroCurso":"1234567890","nomeCurso":"Atualização de clientes sinteticos","categoriaCurso":"Site Reliability Enginner","preRequisito":"Formação DevOps","nomeProfessor":"Kleber Costa","periodoCurso":"12 horas"}' --header "Content-Type:application/json" -X PUT http://${HOST}/cursos/1b12487c-0e99-4237-af07-4b221d054ff2
        fi
    sleep 1.0
done