;;; dired-aft.el --- Send files marked in dired via MTP to connected Android device

;; Copyright (C) 2015 Bastian Ballmann
;; Copyright (C) 2023 Sergei Makarov

;; Author: Bastian Ballmann <balle@codekid.net>
;; Maintainer: Sergei Makarov <setser200018@gmail.com>
;; URL: https://github.com/SeTSeR/dired-aft
;; Created: 15 January 2023
;; Version: 0.1
;; Keywords: tools, dired
;; Package-Requires: (dired)

;; This file is not currently part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program ; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:
;;; Send files marked in dired via MTP to connected Android device

;; To install this package put it somewhere in your `load-path' and add
;; (require 'dired-aft) to your ~/.emacs file
;; Call the function dired-aft-sendfile on marked dired files or add a
;; keybinding with

;; (define-key dired-mode-map "c" 'dired-aft-sendfile)

;; You must have installed android-file-transfer (or whatever package provides aft-mtp-cli binary)

;;; Code:

(defun dired-aft-sendfile (device destdir &optional arg)
  "Send all marked (or next ARG) files, or the current file 
via MTP to connected device"
  (interactive "sCopy to device: \nsDestination directory: ")

  (let* ((file-list (dired-get-marked-files nil arg))
	(device-command (format "-d %s" device))
	(destdir-command (format "cd \"%s\"" destdir))
	(put-commands (mapcar (lambda (file)
				"Format command to put file onto device"
				(format "put \"%s\"" file))
			      file-list))
	(all-commands (append (list "-d" device)
			      (list destdir-command)
			      put-commands)))
    (apply #'make-process
     (append
      (list :name "aft-mtp-cli")
      (list :buffer "*MTP_SENDFILE*")
      (list :command (append (list "aft-mtp-cli") all-commands))))))

(provide 'dired-aft)
;;; dired-aft.el ends here
