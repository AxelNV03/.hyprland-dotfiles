#!/usr/bin/env bash

# =====================================================================
#               INSTALACIÓN DE PAQUETES DE AUR Y AUR
# =====================================================================

# --- 1. Catálogo Limpio de Paquetes AUR ---
PARU_PKGS=(
    "losslesscut-bin"               # Editor de video sin pérdida (Ultra rápido, ideal para clips multimedia)
    "brave-origin-nightly-bin"      # Browser
    "greetd-tuigreet-git"         # Interfaz de texto avanzada (TUI) para greetd que permite loguearte de forma minimalista
    "pwvucontrol"                 # Control de volumen avanzado escrito en GTK4 nativo para PipeWire (Reemplaza a pavucontrol)
    "wlogout"                     # Menú visual a pantalla completa basado en CSS/JSON para gestionar apagado, reinicio y suspensión
)

echo -e "${BLUE}🛠️ Verificando instalador de AUR (Paru)...${NC}"

# 2. Compilación e Instalación Idempotente de Paru
if ! command -v paru &> /dev/null; then
    echo -e "${YELLOW}⏳ Paru no encontrado. Compilando desde origen...${NC}"
    
    # ─── SOLUCIÓN AL BUG ANTERIOR ───
    # Limpiamos preventivamente para que git clone jamás vuelva a decir que la ruta ya existe
    rm -rf /tmp/paru
    
    if git clone https://aur.archlinux.org/paru.git /tmp/paru; then
        (
            cd /tmp/paru || exit 1
            makepkg -si --noconfirm
        )
        rm -rf /tmp/paru
    fi

    # Cláusula de escape si la compilación falla
    if ! command -v paru &> /dev/null; then
        echo -e "${RED}❌ Error crítico: No se pudo consolidar Paru. Abortando...${NC}"
        # Sumamos al contador global para que tu install.sh se entere del fallo
        incrementar_contador_errores 2>/dev/null
        exit 1
    fi
else
    echo -e "✅ Gestor Paru: OK"
fi


# 3. Despliegue en bucle utilizando tus bloques de control
echo -e "${BLUE}📦 Iniciando instalación de paquetes AUR con Paru...${NC}"
for pkg in "${PARU_PKGS[@]}"; do
    execute_step "Instalando desde AUR: $pkg" \
                 "paru -S --needed --noconfirm $pkg" \
                 "$pkg"
done