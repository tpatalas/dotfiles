# Git Config Instruction

## Add git commit template to config

1. Check the current template

```bash
git config --global --get commit.template
```

2. Add commit file, `.gitcommit.txt`, to home directory. ex. `~/.gitcommit.txt`

3. Config gitcommit.txt

```bash
git congit --global commit.template ~/.gitcommit.txt
```
