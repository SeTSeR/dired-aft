dired-mtp
=========

Send files marked in dired via MTP to connected Android device

To install this package put it somewhere in your `load-path' and add
`(require 'dired-aft)` to your `~/.emacs` file

Call the function `dired-aft-sendfile` on marked dired files or add a
keybinding with

```lisp
(define-key dired-mode-map "c" 'dired-aft-sendfile)
```

You must have installed `android-file-transfer` (or whatever package provides `aft-mtp-cli` binary)
