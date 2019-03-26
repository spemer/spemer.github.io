#!/bin/bash
BOLD=$(tput bold)
RESET=$(tput sgr0)

echo "============================================================"
echo "${BOLD}${PWD##*/}${RESET}"
echo "============================================================"

#============================================================
# install missing gems
#============================================================
bundle_install() {
    while true; do
        printf "\n"
        read -p "${BOLD}Install missing gems? (Y/n)${RESET}" yn
        case ${yn} in
            [Yy]* ) bundle install; break;;
            [Nn]* ) return 0;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

#============================================================
# build on a local server (127.0.0.1:4000)
#============================================================
jekyll_serve() {
    while true; do
        printf "\n"
        read -p "${BOLD}Build on a local server? (Y/n)${RESET}" yn
        case ${yn} in
            [Yy]* ) bundle exec jekyll serve; break;;
            [Nn]* ) return 0;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

#============================================================
# git commit
#============================================================
git_commit() {
    while true; do
        printf "\n"
        read -p "${BOLD}git commit? (Y/n)${RESET}" yn
        case ${yn} in
            [Yy]* )
                IFS= read -r -p "${BOLD}Enter commit message: ${RESET}" commitmsg

                # if commitmsg empty
                if [ -z "$commitmsg" ]
                then
                echo "${BOLD}Commit message is empty${RESET}"
                commitmsg="Add files via upload"
                fi

                printf "\n"
                git add .
                git commit -m "$commitmsg"
                break;;

            [Nn]* ) return 0;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

#============================================================
# git push
#============================================================
git_push() {
    while true; do
        printf "\n"
        read -p "${BOLD}git push? (Y/n)${RESET}" yn
        case ${yn} in
            [Yy]* ) git push; break;;
            [Nn]* ) return 0;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

#============================================================
# main
#============================================================
main() {
    bundle_install
    jekyll_serve
    git_commit
    git_push
}

main
