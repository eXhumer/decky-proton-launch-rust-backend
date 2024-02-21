#!/bin/sh

if [ "$RELEASE_TYPE" == "production" ]; then
  cargo build --release
  mkdir -p /out/bin
  cp target/release/proton-launch /out/bin/backend
elif [ "$RELEASE_TYPE" == "development" ]; then
  cargo build
  mkdir -p /out/bin
  cp target/debug/proton-launch /out/bin/backend
else
  echo "Unknown RELEASE_TYPE: $RELEASE_TYPE"
  return -1
fi
