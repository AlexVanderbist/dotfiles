# Load dotfiles binaries
export PATH="$DOTFILES/bin:$PATH"

# Load Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Load Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="node_modules/.bin:vendor/bin:$PATH"

# Load Yarn global installed binaries
export PATH="$HOME/.yarn/bin:$PATH"

# Load Go global installed binaries
export PATH="$HOME/go/bin:$PATH"