# Fish config - convertido do .zshrc

# ============ CachyOS defaults (prompt, greeting, cores) ============
source /usr/share/cachyos-fish-config/cachyos-config.fish

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
alias yup="yay --noconfirm"
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

# df-sync [--check]
#   (sem args)  mostra o que mudaria (dry-run) e pede confirmação antes de aplicar
#   --check     só reporta conflitos, não modifica nada
function df-sync
    if not cd ~/.dotfiles
        echo 'df-sync: não consegui entrar em ~/.dotfiles' >&2
        return 1
    end

    set -l tmp (mktemp)
    stow -n -v -t ~ */ > $tmp 2>&1
    set -l rc $status
    set -l preview (string match -rv '^WARNING: in simulation mode' < $tmp)
    rm -f $tmp

    if test $rc -ne 0
        echo "✗ Há conflitos — nada foi aplicado:"
        string join \n $preview
        return 1
    end

    if test (count $preview) -eq 0
        echo "✓ Tudo já está linkado, nada a aplicar."
        return 0
    end

    echo "== Alterações que serão aplicadas =="
    string join \n $preview
    echo

    if test "$argv[1]" = "--check"
        echo "✓ Sem conflitos (dry-run, nada aplicado)."
        return 0
    end

    read -l -P "Aplicar? [y/N] " resposta
    switch $resposta
        case y Y yes
        case '*'
            echo "Cancelado."
            return 1
    end

    if stow -Rt ~ */
        echo "✓ Dotfiles sincronizados!"
    else
        echo 'df-sync: stow falhou — veja os WARNINGs acima' >&2
        return 1
    end
end

# ============ Zoxide ============
if command -v zoxide >/dev/null
    zoxide init fish | source
end
# ============ Oh My Posh ============
oh-my-posh init fish --config ~/.config/oh-my-posh/sonicboom-dark.omp.json | source
