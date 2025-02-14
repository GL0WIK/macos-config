#!/bin/bash

echo "🚀 Début de la configuration du Mac..."

# 1️⃣ Installation de Homebrew si absent
if ! command -v brew &>/dev/null; then
    echo "🍺 Installation de Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "✅ Homebrew est déjà installé"
fi

# 2️⃣ Installation de Git et Ansible
echo "📦 Installation de Git et Ansible..."
brew install git ansible stow

# 3️⃣ Clonage du dépôt de dotfiles
DOTFILES_DIR="$HOME/.dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "📂 Clonage des dotfiles..."
    git clone https://github.com/ton-repo/dotfiles.git "$DOTFILES_DIR"
else
    echo "✅ Les dotfiles sont déjà présents"
fi

# 4️⃣ Lancer Ansible pour configurer le Mac
echo "⚙️ Lancement d'Ansible pour appliquer la configuration..."
cd "$DOTFILES_DIR"
ansible-playbook mac_setup.yml --ask-become-pass

echo "✅ Configuration terminée ! Redémarre ton Mac pour appliquer tous les changements."