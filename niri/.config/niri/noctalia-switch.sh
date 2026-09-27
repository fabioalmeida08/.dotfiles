#!/usr/bin/env bash
# noctalia-switch — alterna o desktop shell do Noctalia entre v4 (Quickshell) e v5 (nativo)
#
# Uso:
#   ./noctalia-switch.sh      pergunta qual versão usar
#   ./noctalia-switch.sh 4    vai direto pro v4 (aceita também "1")
#   ./noctalia-switch.sh 5    vai direto pro v5 (aceita também "2")
#   ./noctalia-switch.sh -h   ajuda
#
# O que ele faz:
#   1. Para o shell em execução (v4 e/ou v5)
#   2. Reescreve no config.kdl as linhas dependentes da versão:
#      autostart, lid-close, binds (launcher/lock/volume/brilho)
#      e a layer-rule do overview (namespace do wallpaper)
#   3. Valida o config do niri (niri validate)
#   4. Inicia o shell escolhido
#
# O que ele NÃO mexe (cada versão lê só a sua):
#   - ~/.config/noctalia/settings.json, colorschemes/, plugins/     -> v4 (JSON)
#   - ~/.config/noctalia/config.toml, palettes/                     -> v5 (TOML)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CFG="$(readlink -f "$SCRIPT_DIR/config.kdl")"

usage() {
    cat <<'EOF'
noctalia-switch — alterna o desktop shell do Noctalia entre v4 e v5

Uso:
  ./noctalia-switch.sh      pergunta qual versão usar
  ./noctalia-switch.sh 4    vai direto pro v4 (aceita também "1")
  ./noctalia-switch.sh 5    vai direto pro v5 (aceita também "2")
  ./noctalia-switch.sh -h   esta ajuda
EOF
}

die() { echo "ERRO: $*" >&2; exit 1; }

# ─────────────────────────── escolha da versão ───────────────────────────
VER="${1:-}"
case "$VER" in
    1|4) VER=4 ;;
    2|5) VER=5 ;;
    -h|--help) usage; exit 0 ;;
    "") ;;
    *) die "opção inválida: $VER (use 4 ou 5)" ;;
esac

# detecta o que está rodando agora
atual="nenhum"
if pgrep -x noctalia >/dev/null 2>&1; then atual="v5"; fi
if pgrep -f '[q]s -c noctalia-shell' >/dev/null 2>&1; then atual="v4"; fi

if [[ -z "$VER" ]]; then
    echo "Shell em execução: $atual"
    echo
    echo "Qual versão do Noctalia você quer usar?"
    echo "  1) v4 — noctalia-shell (Quickshell, antigo)"
    echo "  2) v5 — noctalia (nativo, atual)"
    read -r -p "Escolha [1/2]: " escolha
    case "$escolha" in
        1|4) VER=4 ;;
        2|5) VER=5 ;;
        *) die "opção inválida: $escolha" ;;
    esac
fi

# ─────────────────────────── pré-checagens ───────────────────────────
[[ -f "$CFG" ]] || die "config.kdl não encontrado: $CFG"
[[ -n "${WAYLAND_DISPLAY:-}" ]] || die "WAYLAND_DISPLAY ausente — rode dentro de uma sessão gráfica (niri)"

if [[ "$VER" == 4 ]]; then
    command -v qs >/dev/null 2>&1 || die "binário 'qs' não encontrado (pacotes noctalia-qs/noctalia-shell)"
else
    command -v noctalia >/dev/null 2>&1 || die "binário 'noctalia' não encontrado (pacote 'noctalia' v5)"
fi

# ───────────────────── reescreve linhas do config.kdl ─────────────────────
# set_line <regex ERE> <linha completa v4> <linha completa v5>
set_line() {
    local pattern="$1" line4="$2" line5="$3" line
    if [[ "$VER" == 4 ]]; then line="$line4"; else line="$line5"; fi
    if grep -qE "$pattern" "$CFG"; then
        sed -i -E "/${pattern}/c\\${line}" "$CFG"
    else
        echo "  AVISO: padrão não encontrado (já está no estado desejado?): $pattern" >&2
    fi
}

echo "Aplicando configurações da v${VER} em $CFG ..."

set_line '^[[:space:]]*lid-close \{ spawn' \
    '    lid-close { spawn "sh" "-c" "qs -c noctalia-shell ipc call sessionMenu lockAndSuspend"; }' \
    '    lid-close { spawn "noctalia" "msg" "session" "lock-and-suspend"; }'

set_line '^[[:space:]]*spawn(-sh)?-at-startup .*noctalia' \
    '    spawn-sh-at-startup "qs -c noctalia-shell" // Launch noctalia (v4)' \
    '    spawn-at-startup "noctalia" // Launch noctalia (v5)'

set_line 'MOD\+SPACE' \
    '    MOD+SPACE                           hotkey-overlay-title="Open App Launcher: qs" { spawn-sh "qs -c noctalia-shell ipc call launcher toggle"; }' \
    '    MOD+SPACE                           hotkey-overlay-title="Open App Launcher: noctalia" { spawn-sh "noctalia msg panel-toggle launcher"; }'

set_line 'MOD\+ALT\+L' \
    '    MOD+ALT+L                           hotkey-overlay-title="Lock Screen" { spawn-sh "qs -c noctalia-shell ipc call lockScreen lock"; }' \
    '    MOD+ALT+L                           hotkey-overlay-title="Lock Screen" { spawn-sh "noctalia msg session lock"; }'

set_line 'XF86AudioRaiseVolume' \
    '    XF86AudioRaiseVolume                allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"; }' \
    '    XF86AudioRaiseVolume                allow-when-locked=true { spawn-sh "noctalia msg volume-up 10"; }'

set_line 'XF86AudioLowerVolume' \
    '    XF86AudioLowerVolume                allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }' \
    '    XF86AudioLowerVolume                allow-when-locked=true { spawn-sh "noctalia msg volume-down 10"; }'

set_line 'XF86AudioMute' \
    '    XF86AudioMute                       allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }' \
    '    XF86AudioMute                       allow-when-locked=true { spawn-sh "noctalia msg volume-mute"; }'

set_line 'XF86AudioMicMute' \
    '    XF86AudioMicMute                    allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }' \
    '    XF86AudioMicMute                    allow-when-locked=true { spawn-sh "noctalia msg mic-mute"; }'

set_line 'XF86MonBrightnessUp' \
    '    XF86MonBrightnessUp     allow-when-locked=true { spawn-sh "brightnessctl set +10%"; }' \
    '    XF86MonBrightnessUp     allow-when-locked=true { spawn-sh "noctalia msg brightness-up"; }'

set_line 'XF86MonBrightnessDown' \
    '    XF86MonBrightnessDown   allow-when-locked=true { spawn-sh "brightnessctl set 10%-"; }' \
    '    XF86MonBrightnessDown   allow-when-locked=true { spawn-sh "noctalia msg brightness-down"; }'

set_line 'namespace="\^noctalia-(backdrop|overview)"' \
    '      match namespace="^noctalia-overview"' \
    '      match namespace="^noctalia-backdrop"'

# ─────────────────────────── para os shells ───────────────────────────
echo "Parando shells em execução (se houver)..."
pkill -x noctalia 2>/dev/null || true
pkill -f '[q]s -c noctalia-shell' 2>/dev/null || true
sleep 1

# ─────────────────────────── valida o niri ───────────────────────────
echo "Validando config do niri..."
if niri validate >/dev/null 2>&1; then
    echo "  ✓ config válido"
else
    niri validate || true
    die "config do niri inválido após a troca — confira o output acima"
fi

# ─────────────────────────── inicia o shell ───────────────────────────
LOG="${TMPDIR:-/tmp}/noctalia-v${VER}.log"
if [[ "$VER" == 4 ]]; then
    setsid nohup qs -c noctalia-shell >"$LOG" 2>&1 < /dev/null &
else
    setsid nohup noctalia >"$LOG" 2>&1 < /dev/null &
fi

sleep 2
rodando=0
if [[ "$VER" == 4 ]]; then
    pgrep -f '[q]s -c noctalia-shell' >/dev/null 2>&1 && rodando=1
else
    pgrep -x noctalia >/dev/null 2>&1 && rodando=1
fi

echo
if [[ "$rodando" == 1 ]]; then
    echo "✓ Noctalia v${VER} ativo (anterior: $atual)"
else
    echo "⚠ Não confirmei o início do shell — veja o log: $LOG" >&2
fi

echo "Linhas do config.kdl agora em v${VER}:"
grep -nE 'lid-close \{|spawn(-sh)?-at-startup "(noctalia|qs)|MOD\+SPACE|MOD\+ALT\+L|XF86AudioRaiseVolume|XF86MonBrightnessUp|namespace="\^noctalia' "$CFG"
