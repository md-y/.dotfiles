## Updating mMdpack

- Use packwiz (such as through `nix-shell -p packwiz`) to update modpack
- Commit changes to github
- Update URL in `minecraft.nix` to point to updated file
- Change SHA hash to something different (but still a valid SHA hash)
- Rebuild and switch, then look for correct hash in error logs
- If server service is not stopping, try to force stop it and then wait:
```bash
sudo systemctl stop minecraft-server-default.service
```
- Update config with new hash
- Rebuild and switch again

## Accessing Console

```bash
sudo -u minecraft bash
tmux -S /run/minecraft/default.sock attach
```