{ pkgs, lib, ... }:

{
  environment.variables = {
    CGO_ENABLED="1";
  };
}
