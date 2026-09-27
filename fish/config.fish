# Fish config - convertido do .zshrc

# ============ PATH ============
set -gx PATH $HOME/.local/bin $HOME/.cargo/bin $PATH

# ============ Variáveis ============
set -gx EDITOR nvim
set -gx VISUAL nvim

# ============ Aliases ============
alias vg="vagrant"
alias vgu="vagrant up"
alias vgp="vagrant provision"
alias vgh="vagrant halt"
alias vgd="vagrant destroy -f"
alias vgs="vagrant ssh"
alias ap="ansible-playbook"
alias kl="kubectl"
alias kcf="kubectl create -f"
alias kaf="kubectl apply -f"
alias kgp="kubectl get pods"
alias kgpv="kubectl get pv"
alias kgpvc="kubectl get pvc"
alias kcn="kubectl create ns"
alias kd="kubectl describe"
alias kdlf="kubectl delete -f"
alias kdl="kubectl delete"
alias r="ranger"
alias ta="task add"
alias tl="task list"
alias td="task done"
alias bt="btop"
alias pof="poweroff"
alias rbt="reboot"
alias ls="lsd"
alias l="ls -al"
alias yup="yay --noconfirm; and flatpak update -y"
alias yof="yup; and pof"
alias n="nvim"
alias yy="yazi"
alias lg="lazygit"
alias cp="rsync -ahv --info=progress2"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gpo="git pull"
alias gs="git status -s"
alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias gco="git checkout"
alias gsw="git switch"
alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias cleanup="sudo pacman -Rsn (pacman -Qtdq)"
alias jctl="journalctl -p 3 -xb"
alias spwn="ssh -i ~/.ssh/pwnkey hacker@dojo.pwn.college"
alias oc="opencode"
alias dotfiles-sync="cd ~/.dotfiles; and stow -Rt ~ */; and echo 'Dotfiles sincronizados!'"

# ============ Funções ============

function ksc
    kubectl config set-context (kubectl config current-context) --namespace="$argv[1]"
end

function kdg
    kubectl describe $argv[1] | grep $argv[2]
end

function nv
    neovide $argv &
    disown
end

# ============ Zoxide ============
if command -v zoxide >/dev/null
    zoxide init fish | source
end
# ============ Oh My Posh ============
oh-my-posh init fish --config ~/.cache/oh-my-posh/themes/sonicboom_dark.omp.json | source
