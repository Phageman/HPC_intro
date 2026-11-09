# Part 2: Git

Start in your `HPC_intro/exercise_data`.
● basic, ●● intermediate, ●●● advanced (optional)

## Your own copy

### 2.1 Fork the repository ●

1. Log in on GitHub, or create an account
2. Go to <https://github.com/bayraktar1/HPC_intro> and click **Fork** to make your own copy

### 2.2 Where does your clone come from? ●

The clone you made at the start still points to the original repository. Check it:

```bash
git remote -v
```

*Expected:*

```
origin  https://github.com/bayraktar1/HPC_intro.git (fetch)
origin  https://github.com/bayraktar1/HPC_intro.git (push)
```

## SSH key for GitHub

### 2.3 Tell Git who you are ●

Once per computer:

```bash
git config --global user.name "<Your Name>"
git config --global user.email "<your email>"
```

### 2.4 Set up your SSH key ●●

Already have a key? If `ls ~/.ssh` shows a `.pub` file (not the `_hpc` one), use it and skip step 1.

1. Create a key pair: press `Enter` for the default location, then choose a passphrase
2. Print your public key and copy it
3. On GitHub: **Settings** → **SSH and GPG keys** → **New SSH key**, and paste it
4. Test the connection. The first time, type `yes`

```bash
ssh-keygen -t ed25519 -C "<your email>"   # step 1
cat ~/.ssh/id_ed25519.pub                 # step 2, or your existing .pub
ssh -T git@github.com                     # step 4
```

*Expected:* "Hi <user>! You've successfully authenticated, but GitHub does not provide shell access."
That means it works.

## Saving your work

### 2.5 Your first commit ●●

1. Run `git status`
2. Stage `my_work/notes.txt` with `git add`, and run `git status` again
3. Commit it: `git commit -m "Add my notes"`
4. Look at the history with `git log --oneline`

*Expected:*

1. `my_work/` and `count.sh` are untracked: Git does not follow them yet
2. `notes.txt` is under "Changes to be committed"
4. your commit is at the top

### 2.6 Undo a change ●●●

Change `my_work/notes.txt` with `nano`, look at the change with `git diff`,
then undo it with `git restore my_work/notes.txt`.

*Expected:* `cat my_work/notes.txt` shows the committed version again

### 2.7 Push to your fork ●●

Point your clone to your fork, over SSH so your key does the work.
Then commit your script and push all your commits:

```bash
git remote set-url origin git@github.com:<user>/HPC_intro.git
git remote -v           # check: now your fork
git add count.sh
git commit -m "Add my count script"
git push
```

No `count.sh`? Skip the `git add` and `git commit` lines, and just push.

*Expected:* refresh your fork on GitHub: your files are there
