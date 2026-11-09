#!/bin/bash
# Solutions, part 2: Git.
# Everything here changes your repository or GitHub, so it is shown as comments:
# type the commands yourself, in your HPC_intro/exercise_data.

## 2.1 Fork the repository
# On GitHub: github.com/bayraktar1/HPC_intro -> Fork

## 2.2 Where does your clone come from?
# git remote -v                      # origin: bayraktar1/HPC_intro

## 2.3 Tell Git who you are
# git config --global user.name "Your Name"
# git config --global user.email "you@example.com"

## 2.4 Set up your SSH key
# ls ~/.ssh                          # existing .pub key? then skip ssh-keygen
# ssh-keygen -t ed25519 -C "you@example.com"
# cat ~/.ssh/id_ed25519.pub          # paste this on GitHub
# ssh -T git@github.com              # "Hi <user>! You've successfully authenticated..."

## 2.5 Your first commit
# git status                         # my_work/ and count.sh are untracked
# git add my_work/notes.txt
# git status                         # notes.txt: Changes to be committed
# git commit -m "Add my notes"
# git log --oneline

## 2.6 Undo a change
# nano my_work/notes.txt             # change something
# git diff                           # shows the change
# git restore my_work/notes.txt      # undo it

## 2.7 Push to your fork
# git remote set-url origin git@github.com:<user>/HPC_intro.git
# git remote -v
# git add count.sh
# git commit -m "Add my count script"
# git push
