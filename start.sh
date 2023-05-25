#!/bin/bash
arg=${1}
DATE_TIME=`date '+%Y-%m-%d %H:%M:%S'`
export WEB_ADDR="http://localhost:8080"

pre() {
  printf "Python version: {`python --version`} \n" 
  printf "Python3 version: {`python3 --version`} \n" 
  printf "PIP version: {`pip --version`} \n" 
  printf "PIP3 version: {`pip3 --version`} \n"  
}
init() {
    git fetch 
    pip3 install --upgrade pip
    pip3 install fschat
    brew install rust cmake
    pip3 install -e .
}
chat_cli(){
    python3 -m fastchat.serve.cli --model-path lmsys/fastchat-t5-3b-v1.0 
}
chat_web() {
    # launc controller
    python3 -m fastchat.serve.controller & 
    sleep 5

    # Launch the model worker
    python3 -m fastchat.serve.model_worker --model-path lmsys/fastchat-t5-3b-v1.0 --device cpu & 
    sleep 5

    # Launch the web server
    #python3 -m fastchat.serve.gradio_web_server --port 8080 &
    python3 -m fastchat.serve.gradio_web_server --host 127.0.0.1 --port 8080 &
    sleep 10

    echo "Opening browser $WEB_ADDR"
    open -a 'Google Chrome' $WEB_ADDR
}

printf "\n  ------------------------ [BEGIN at {`date '+%Y-%m-%d %H:%M:%S'`}] ------------------------ \n "
printf " -------------------------------------------------------------------------------------------- \n "
printf "         ********     **      ******** **********   ******  **      **     **     ********** \n "
printf "        /**/////     ****    **////// /////**///   **////**/**     /**    ****   /////**///  \n "
printf "        /**         **//**  /**           /**     **    // /**     /**   **//**      /**     \n "
printf "        /*******   **  //** /*********    /**    /**       /**********  **  //**     /**     \n "
printf "        /**////   **********////////**    /**    /**       /**//////** **********    /**     \n "
printf "        /**      /**//////**       /**    /**    //**    **/**     /**/**//////**    /**     \n "
printf "        /**      /**     /** ********     /**     //****** /**     /**/**     /**    /**     \n "
printf "        //       //      // ////////      //       //////  //      // //      //     //      \n "
printf " -------------------------------------------------------------------------------------------- \n "


if [[ -n $arg ]] ; then
    # param
    arg_len=${#arg} 
    # uppercase the argument
    arg=$(echo ${arg} | tr [a-z] [A-Z] | xargs)
    echo "Action: ${arg} and length is NOT ZERO: ${arg_len}"

    if  [[ "PRE" == "${arg}" ]] ; then 
        pre
    elif  [[ "INIT" == "${arg}" ]] ; then 
        init
    elif  [[ "CLI" == "${arg}" ]] ; then
        chat_cli
    elif  [[ "WEB" == "${arg}" ]] ; then
        chat_web
    else
        echo "Action NOT CONFIGURED"
        echo "Action argument length is ZERO"
        printf "\n commands... \n   1. ./start.sh pre  --> prerequisite check \n   2. ./start.sh init  --> initial setup\n   3. ./start.sh cli  --> Chat via CLI\n   4. ./start.sh web  --> Web based chat app\n "
    fi
else 
    chat_web
fi


printf "\n -------------------- [Started at {`date '+%Y-%m-%d %H:%M:%S'`}] -------------------- \n "
