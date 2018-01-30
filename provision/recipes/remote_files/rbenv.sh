export RBENV_ROOT="/usr/local/rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"

# `rbenv rehash -` はbinを持つgemを入れた時にやればいいので、ここでは実行しない
eval "$(rbenv init --no-rehash -)"
