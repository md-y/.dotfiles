let
  homeserver_root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE4gU8gWpZGZB21kPw9cj6u2mJbCtemf2r5Gryh1ugTm root@homeserver";
  homeserver_user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA//LbpDMArHi2plHRFAJxUHYTT2V5GhIuW7eHL899KS sam@homeserver";
in
{
  "frigate-env.age".publicKeys = [ homeserver_root homeserver_user ];
}
