#!/bin/bash
# Deploy prangworld.de auf den Hetzner-Server (tar ueber SSH, Releases + Link "current").
# Aufruf aus dem Projektordner:  ./deploy.sh            -> veroeffentlichen
#                                ./deploy.sh rollback   -> auf vorige Version zurueck
# Veroeffentlicht wird nur nach OK von Sebastian.
set -euo pipefail

HOST="${DEPLOY_HOST:-162.55.218.18}"
USER_="deploy"
KEY="${DEPLOY_KEY:-$HOME/.ssh/prangworld_deploy}"
BASE="/var/www/prangworld"
KEEP=5
SSH=(ssh -i "$KEY" -o BatchMode=yes -o StrictHostKeyChecking=yes "$USER_@$HOST")

cd "$(dirname "$0")"

if [ "${1:-}" = "rollback" ]; then
  "${SSH[@]}" "cd $BASE && cur=\$(readlink current) && prev=\$(ls -1d releases/* | sort | grep -B1 -x \"\$cur\" | head -1) && [ -n \"\$prev\" ] && [ \"\$prev\" != \"\$cur\" ] && ln -sfn \"\$prev\" current.tmp && mv -T current.tmp current && echo \"zurueck auf \$prev\""
  exit 0
fi

REL="releases/$(date +%Y%m%d-%H%M%S)"
echo "Neue Version: $REL"
"${SSH[@]}" "mkdir -p $BASE/$REL"

tar -c --exclude='.git' --exclude='docs-intern' --exclude='README.md' --exclude='CNAME' --exclude='.nojekyll' \
    --exclude='deploy.sh' --exclude='.gitignore' --exclude='.DS_Store' --exclude='Thumbs.db' . \
  | "${SSH[@]}" "tar -x --no-same-owner --no-same-permissions -C $BASE/$REL && find $BASE/$REL -type d -exec chmod 755 {} + && find $BASE/$REL -type f -exec chmod 644 {} +"

"${SSH[@]}" "cd $BASE && ln -sfn $REL current.tmp && mv -T current.tmp current && ls -1d releases/* | sort | head -n -$KEEP | xargs -r rm -rf && readlink current"
echo "Fertig. Pruefen: curl -sI http://$HOST/"
