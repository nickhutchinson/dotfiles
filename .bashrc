# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Base16 Shell
export BASE16_SCHEME="solarized"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# User specific aliases and functions
source /workspace/Katana/QA_Resources/Resources/Apps/Katana/Modules/.qaBashrc
source /opt/intel/vtune_amplifier_xe_2013/amplxe-vars.sh >/dev/null
export PATH=$PATH:$HOME/opt/FBuildTools
export TERM=xterm-256color

export PYTHONPATH=$PYTHONPATH:/opt/eclipse/dropins/plugins/org.python.pydev_2.8.2.2013090511/pysrc/:$HOME/.vim/pyclewn/bin/lib/python/
