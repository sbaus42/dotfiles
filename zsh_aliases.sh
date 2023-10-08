alias gco="git checkout"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias shire-stats='sudo systemctl status openvpn@shire.service'
alias shire-start='sudo systemctl start openvpn@shire.service && shire-stats'
alias shire-stop='sudo systemctl stop openvpn@shire.service && shire-stats'
alias shire-restart='sudo systemctl restart openvpn@shire.service && shire-stats'
alias configs="cd /home/santi/crealytics/repos/project-configs"
alias prod-cluster="gcloud container clusters get-credentials eu-main-production-kubernetes --region=europe-west1"
alias staging-cluster="gcloud container clusters get-credentials eu-main-staging-kubernetes --region=europe-west1"
alias gstat="git status"
alias dco="docker-compose"
alias configaro_stg="psql -h 10.132.0.27 -p 5434 -U configaro configaro"
alias configaro_prod="psql -h 10.132.0.27 -p 5534 -U configaro configaro"

