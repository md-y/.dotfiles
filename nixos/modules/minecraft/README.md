## Updating modpack

- Use packwiz (such as through `nix-shell -p packwiz`) to update modpack
- Commit changes to github
- Change SHA hash to something different (but still a valid SHA hash)
- Rebuild and switch, then look for correct hash in error logs
- If server service is not stopping, try to force stop it and then wait:
```bash
sudo systemctl kill minecraft-server-default.service
```
- Update config with new hash
- Update config with new MC version and Fabric loader
- Update `nix-minecraft`:
```bash
nix flake update nix-minecraft
```
- Rebuild and switch again

## Accessing Console

```bash
sudo -u minecraft bash
tmux -S /run/minecraft/default.sock attach
```