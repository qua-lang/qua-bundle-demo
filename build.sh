#!/usr/bin/env bash
set -eux
rm -f balls.lisp.json qua-demo.js
qua-bundle balls.lisp qua-demo.js
