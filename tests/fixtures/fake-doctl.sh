#!/bin/sh
# Fake doctl script for testing - accepts all commands and exits 0
case "$1" in
  version)
    echo "doctl version fake (linux amd64)"
    ;;
  auth)
    echo "Validating token... OK"
    ;;
  *)
    echo "doctl fake: $*"
    ;;
esac
exit 0
